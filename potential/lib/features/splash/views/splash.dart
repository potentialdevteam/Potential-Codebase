import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/onboarding/views/welcome_landing.dart';
import 'package:potential/features/auth/cubits/auth.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/home/views/layout.dart';
import 'package:potential/features/splash/helpers/splash_screen_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPageIndex = 0;
  double _opacity = 1.0;
  final Duration _fadeDuration = Duration(milliseconds: 300);
  late Map<int, Map<String, String>> screenMappings;

  @override
  void initState() {
    super.initState();
    screenMappings = getScreenMappings();
  }

  Future<void> _goToNextPage() async {
    if (currentPageIndex == 0 && context.mounted) {
      final isLoggedIn = context.read<AuthCubit>().state.isLoggedIn;

      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          FadeRouteTransition(dest: const HomeLayout()),
        );
        return;
      } else {
        Navigator.pushReplacement(
          context,
          FadeRouteTransition(dest: const WelcomeLanding()),
        );
        return;
      }
    }

    if (currentPageIndex == 3) {
      Navigator.pushReplacement(
        context,
        FadeRouteTransition(dest: const WelcomeLanding()),
      );
      return;
    }
    // trigger fade out
    setState(() {
      _opacity = 0.0;
    });

    // wait for fade out
    await Future.delayed(_fadeDuration);

    if (currentPageIndex < 3) {
      setState(() {
        currentPageIndex++;
      });
    }
    // trigger fade in
    setState(() {
      _opacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: _opacity,
            duration: _fadeDuration,
            child:
                Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: screenWidth * 0.6,
                          height: screenWidth * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentRed.withAlpha(70),
                                spreadRadius: 2,
                                blurRadius: 150,
                                blurStyle: BlurStyle.normal,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: currentPageIndex == 0
                              ? SvgPicture.asset('assets/svg/app_logo.svg')
                              : LottieBuilder.asset(
                                  screenMappings[currentPageIndex]!["asset"]!,
                                  width: screenWidth * 0.8,
                                  height:
                                      screenWidth * 0.8, // or 0.6 for height
                                ),
                        ),
                      ],
                    )
                    .animate()
                    .scale(
                      begin: Offset.zero,
                      end: const Offset(1, 1),
                      duration: const Duration(seconds: 1),
                    )
                    .fadeIn(duration: const Duration(seconds: 1)),
          ),

          // Options near the bottom
          Positioned(
                bottom: screenHeight * 0.1,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: _fadeDuration,
                      child: Text(
                        textAlign: TextAlign.center,
                        screenMappings[currentPageIndex]!["text"]!,
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    OnboardingButton(
                      onPressed: _goToNextPage,
                      text: "Continue",
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.accentWhite,
                      ),
                    ),
                  ],
                ),
              )
              .animate(delay: const Duration(seconds: 1))
              .fadeIn(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              ),
        ],
      ),
    );
  }
}
