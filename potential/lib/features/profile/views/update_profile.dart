import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/profile/cubit/updatable_fields.dart';
import 'package:potential/features/profile/views/updatable_fields/update_education.dart';
import 'package:potential/features/profile/views/updatable_fields/update_first_move.dart';
import 'package:potential/features/profile/views/updatable_fields/update_gender.dart';
import 'package:potential/features/profile/views/updatable_fields/update_mystery_mode.dart';
import 'package:potential/features/profile/views/updatable_fields/update_social_media.dart';
import 'package:potential/features/profile/views/updatable_fields/update_voice_prompt.dart';
import 'package:potential/features/profile/views/updatable_fields/update_work.dart';
import 'package:potential/features/profile/widgets/profile_picture_box.dart';
import 'package:potential/features/profile/widgets/updatable_field.dart';
import 'package:potential/features/profile/widgets/user_profile_pic_completion.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late final PlayerController playerController;
  bool isPlaying = false;
  late String recordedAudioPath;
  late final Map<String, Widget> screenMappings;
  late final UpdatableFieldsData userData;

  late final FieldWithVisibility voicePrompt;

  @override
  void initState() {
    super.initState();
    playerController = PlayerController();
    playerController.onPlayerStateChanged.listen((listener) {
      setState(() {
        isPlaying = listener.isPlaying;
      });
    });

    userData = fetchRelevantData(context);
    recordedAudioPath = context
        .read<CreateAccountCubit>()
        .state
        .voicePrompt
        .value
        .toString();

    screenMappings = _getScreenMappings();
  }

  void selectImage(BuildContext context, String? file) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (!context.mounted) return;
    if (file != null && image != null) {
      final String newImage = image.path;
      context.read<CreateAccountCubit>().updateSelectedImages(file, newImage);
    } else if (image != null && file == null) {
      final String newImage = image.path;
      context.read<CreateAccountCubit>().addImage(newImage);
    }
  }

  void removeImage(BuildContext context, String image) {
    context.read<CreateAccountCubit>().removeImage(image);
  }

  UpdatableFieldsData fetchRelevantData(BuildContext context) {
    final createAccountState = context.read<CreateAccountCubit>().state;
    final updatableFieldsState = context.read<UpdatableFieldsCubit>().state;

    // equate all values of createAccountState to updatableFieldsState
    UpdatableFieldsData updatedData = UpdatableFieldsData(
      profilePicture: createAccountState.profilePicture,
      voicePrompt: updatableFieldsState.voicePrompt,
      genderPreference: updatableFieldsState.genderPreference,
      education: updatableFieldsState.education,
      workExperience: updatableFieldsState.workExperience,
      socialMediaHandle: updatableFieldsState.socialMediaHandle,
      firstMove: updatableFieldsState.firstMove,
      mysteryModeEnabled: updatableFieldsState.mysteryModeEnabled,
    );

    context.read<UpdatableFieldsCubit>().updateAllFields(updatedData);

    return updatedData;
  }

  Future<void> toggleAudioPlayback(
    PlayerController playerController,
    String recordedAudioPath,
  ) async {
    if (recordedAudioPath.isNotEmpty && File(recordedAudioPath).existsSync()) {
      if (playerController.playerState.isPlaying) {
        await playerController.stopAllPlayers();
      } else {
        await playerController.stopPlayer();
        await playerController.preparePlayer(path: recordedAudioPath);
        await playerController.startPlayer(forceRefresh: true);
      }
    } else {
      CustomSnackBarHelper.showCustomSnackbar(
        context,
        "No voice prompt recorded yet.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        title: Text(
          "Profile",
          style: TextStyle(color: AppColors.accentWhite, fontSize: 25),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width * 0.14,
            height: width * 0.14,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.accentRed, width: 2),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.accentWhite,
              ),
              iconSize: 17,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              UserProfilePictureCompletion(
                width: width,
                height: height,
                onTap: () {},
              ),
              BlocBuilder<CreateAccountCubit, CreateAccountData>(
                builder: (context, state) {
                  return Text(
                    "${state.name.value}, ${state.age.value}",
                    style: TextStyle(
                      color: AppColors.accentWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  );
                },
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                width: width * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Your Profile Pictures",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: height * 0.02),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                            BlocBuilder<CreateAccountCubit, CreateAccountData>(
                              builder: (context, state) {
                                final screenWidth = MediaQuery.of(
                                  context,
                                ).size.width;
                                final profilePictures = state.profilePicture;

                                return Row(
                                  children: [
                                    ...profilePictures.map(
                                      (file) => Padding(
                                        padding: EdgeInsets.only(
                                          right: screenWidth * 0.05,
                                        ),
                                        child: ProfilePictureBox(
                                          image: File(file),
                                          onPressed: () =>
                                              selectImage(context, file),
                                          onRemove: () =>
                                              removeImage(context, file),
                                        ),
                                      ),
                                    ),
                                    // limit the number of pictures to 3
                                    if (profilePictures.length < 3)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: screenWidth * 0.05,
                                        ),
                                        child: ProfilePictureBox(
                                          onPressed: () =>
                                              selectImage(context, null),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                      ),
                    ),
                    Text(
                      "Tap to edit",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Text(
                      "At Most, 3 will be displayed",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              SizedBox(
                width: width * 0.85,
                child: Column(
                  children: [
                    _buildVoicePrompt(width, height),

                    SizedBox(height: height * 0.02),

                    BlocBuilder<CreateAccountCubit, CreateAccountData>(
                      builder: (context, state) {
                        return UpdatableField(
                          fieldName: "Gender Preference",
                          fieldValue: state.genderPreference.value.toString(),
                          screenMappings: screenMappings,
                        );
                      },
                    ),

                    SizedBox(height: height * 0.02),

                    BlocBuilder<CreateAccountCubit, CreateAccountData>(
                      builder: (context, state) {
                        return UpdatableField(
                          fieldName: "Education",
                          fieldValue: state.education.value.toString(),
                          screenMappings: screenMappings,
                        );
                      },
                    ),

                    SizedBox(height: height * 0.02),

                    BlocBuilder<CreateAccountCubit, CreateAccountData>(
                      builder: (context, state) {
                        return UpdatableField(
                          fieldName: "Work Experience",
                          fieldValue: state.workExperience.value.toString(),
                          screenMappings: screenMappings,
                        );
                      },
                    ),
                    SizedBox(height: height * 0.02),

                    BlocBuilder<CreateAccountCubit, CreateAccountData>(
                      builder: (context, state) {
                        return UpdatableField(
                          fieldName: "Social Media Handle",
                          fieldValue: state.socialMediaHandle.value.toString(),
                          screenMappings: screenMappings,
                        );
                      },
                    ),

                    SizedBox(height: height * 0.02),

                    BlocBuilder<CreateAccountCubit, CreateAccountData>(
                      builder: (context, state) {
                        return UpdatableField(
                          fieldName: "Mystery Mode",
                          fieldValue: state.mysteryModeEnabled
                              ? "Enabled"
                              : "Disabled",
                          screenMappings: screenMappings,
                        );
                      },
                    ),

                    SizedBox(height: height * 0.02),

                    BlocBuilder<CreateAccountCubit, CreateAccountData>(
                      builder: (context, state) {
                        return UpdatableField(
                          fieldName: "First Move",
                          fieldValue: state.firstMove,
                          screenMappings: screenMappings,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoicePrompt(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Your Voice Bio",
            style: TextStyle(
              color: Colors.grey,
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          splashColor: AppColors.soulYellow,
          child: Container(
            width: width * 0.85,
            height: height * 0.1,
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.symmetric(
                horizontal: BorderSide(color: AppColors.accentRed, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async => await toggleAudioPlayback(
                    playerController,
                    context
                        .read<CreateAccountCubit>()
                        .state
                        .voicePrompt
                        .value
                        .toString(),
                  ),
                  icon: Icon(
                    playerController.playerState.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                    color: AppColors.accentWhite,
                    size: width * 0.08,
                  ),
                ),
                Expanded(
                  child: AudioFileWaveforms(
                    size: Size(width * 0.55, height * 0.08),
                    playerController: playerController,
                    continuousWaveform: true,
                    waveformType: WaveformType.long,
                    backgroundColor: Colors.transparent,
                    enableSeekGesture: false,
                    playerWaveStyle: PlayerWaveStyle(
                      showSeekLine: false,
                      fixedWaveColor: const Color.fromARGB(255, 87, 86, 86),
                      liveWaveColor: AppColors.accentWhite,
                      spacing: 4,
                      scaleFactor: 100,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    FadeRouteTransition(dest: UpdateVoicePromptScreen()),
                  ),
                  child: Container(
                    width: width * 0.1,
                    height: width * 0.1,
                    decoration: BoxDecoration(
                      color: AppColors.accentWhite,
                      borderRadius: BorderRadius.circular(width * 0.03),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentRed.withAlpha(200),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.pencil,
                        color: AppColors.accentRed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.01),
      ],
    );
  }

  _getScreenMappings() {
    return {
      "Voice Prompt": Placeholder(),
      "Gender Preference": UpdateGenderPreference(),
      "Education": UpdateEducationScreen(),
      "Work Experience": UpdateWorkScreen(),
      "Social Media Handle": UpdateSocialMediaScreen(),
      "First Move": UpdateFirstMoveScreen(),
      "Mystery Mode": UpdateMysteryModeScreen(),
    };
  }
}
