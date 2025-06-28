import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:potential/core/configs/theme_extention.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';

class ProfileVoicePrompt extends StatefulWidget {
  const ProfileVoicePrompt({super.key});

  @override
  State<ProfileVoicePrompt> createState() => ProfileVoicePromptState();
}

class ProfileVoicePromptState extends State<ProfileVoicePrompt> {
  late final RecorderController recorderController;
  bool _isRecording = false;

  late final PlayerController playerController;
  bool _isPlaying = false;

  String? _recordedAudioPath;

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
    playerController = PlayerController();

    playerController.onPlayerStateChanged.listen((event) {
      log("Player state changed: $event");
      setState(() {
        _isPlaying = event == PlayerState.playing;
      });
      playerController.setRefresh(true);
    });
    playerController.updateFrequency = UpdateFrequency.high;

    registerFilePath();
  }

  Future<void> registerFilePath() async {
    final Directory applicationDirectory =
        await getApplicationDocumentsDirectory();
    String filePath =
        "${applicationDirectory.path}/${DateTime.now().microsecondsSinceEpoch}.m4a";

    setState(() {
      _recordedAudioPath = filePath;
    });
    log("Audio path registered: $_recordedAudioPath");
  }

  Future<void> _beginRecording() async {
    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      log("Microphone permission not granted");
      return;
    }
    if (_recordedAudioPath == null) {
      await registerFilePath();
    }

    if (_isPlaying) {
      await playerController.stopAllPlayers();
    }

    // Start the recording finally
    setState(() {
      _isRecording = true;
    });
    await recorderController.record(path: _recordedAudioPath!);
    log("Recording started");
  }

  Future<void> _endRecording(BuildContext context) async {
    String? filePath = await recorderController.stop();
    if (filePath != null) {
      setState(() {
        _isRecording = false;
        _recordedAudioPath = filePath;
      });

      if (context.mounted) {
        context.read<CreateAccountCubit>().updateVoicePrompt(filePath);
        log("Voice prompt updated");
      }

      log("Recording saved at: $filePath");
      await playerController.preparePlayer(path: filePath);
    }
  }

  Future<void> toggleAudioPlayback() async {
    if (_recordedAudioPath != null && File(_recordedAudioPath!).existsSync()) {
      if (_isPlaying) {
        await playerController.stopAllPlayers();
        setState(() {
          _isPlaying = false;
        });
      } else {
        await playerController.stopPlayer();
        await playerController.preparePlayer(path: _recordedAudioPath!);
        await playerController.startPlayer(forceRefresh: true);
        setState(() {
          _isPlaying = true;
        });
      }
    } else {
      log("No recorded audio found to play.");
    }
  }

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: height * 0.05),
        width: width * 0.80,
        child: Column(
          spacing: MediaQuery.of(context).size.height * 0.02,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Add a voice bio to stand out!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),

            Text(
              "This is an optional field.",
              style: TextStyle(color: AppColors.accentWhite),
            ),

            Container(
              width: width * 0.8,
              height: height * 0.3,
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: height * 0.02,
                    child: Text(
                      "00:00 / 00:30",
                      style: TextStyle(color: AppColors.accentWhite),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: width * 0.7,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        color: context.colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.accentWhite,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: AudioWaveforms(
                          size: Size(width * 0.7, height * 0.1),
                          recorderController: recorderController,
                          enableGesture: false,
                          waveStyle: WaveStyle(
                            showMiddleLine: false,
                            waveColor: AppColors.accentRed,
                            backgroundColor: Colors.transparent,
                            showDurationLabel: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: height * 0.025,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.accentRed, AppColors.accentWhite],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          if (_isRecording) {
                            await _endRecording(context);
                            return;
                          }
                          await _beginRecording();
                        },
                        icon: Icon(
                          _isRecording ? Icons.stop : Icons.mic,
                          size: width * 0.05,
                          color: AppColors.accentWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (_recordedAudioPath != null &&
                File(_recordedAudioPath!).existsSync())
              Center(
                child: Container(
                  width: width * 0.7,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: context.colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.accentWhite, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async => await toggleAudioPlayback(),
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                          color: AppColors.accentWhite,
                          size: width * 0.08,
                        ),
                      ),
                      AudioFileWaveforms(
                        size: Size(width * 0.5, height * 0.1),
                        playerController: playerController,
                        continuousWaveform: true,
                        waveformType: WaveformType.long,
                        backgroundColor: Colors.transparent,
                        enableSeekGesture: false,
                        playerWaveStyle: PlayerWaveStyle(
                          showSeekLine: false,
                          fixedWaveColor: Colors.grey,
                          liveWaveColor: AppColors.accentRed,
                          spacing: 4,
                          scaleFactor: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
