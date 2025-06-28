import 'package:flutter/material.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/onboarding/helpers/onboarding_helper.dart';
import 'package:potential/features/onboarding/helpers/user_info_validator.dart';
import 'package:potential/features/onboarding/views/profile_pictures.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class ProfileCreationScreen extends StatefulWidget {
  const ProfileCreationScreen({super.key});

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  final Duration _fadeDuration = const Duration(milliseconds: 300);
  double _opacity = 1.0;
  int currentPageIndex = 0;
  final OnboardingHelperClass _onboardingHelperClass = OnboardingHelperClass();

  late Map<int, Widget> _profileCreationData;

  @override
  void initState() {
    super.initState();
    _profileCreationData = OnboardingHelperClass.getProfileCreationData();
  }

  void _goToNextPage(BuildContext context) async {
    if (currentPageIndex == 0) {
      if (!UserInfoValidator.isNameValid(context)) {
        CustomSnackBarHelper.showCustomSnackbar(
          context,
          "Name entered is not valid.",
        );
        return;
      }
    }
    if (currentPageIndex == 1) {
      if (!UserInfoValidator.isDateOfBirthValid(context)) {
        CustomSnackBarHelper.showCustomSnackbar(
          context,
          "Date of birth entered is not valid.",
        );
        return;
      }
    }
    if (currentPageIndex == 2) {
      if (!UserInfoValidator.isGenderValid(context)) {
        CustomSnackBarHelper.showCustomSnackbar(
          context,
          "Gender entered in not valid.",
        );
        return;
      }
    }

    if (currentPageIndex == 3) {
      if (!UserInfoValidator.isGenderPreferenceValid(context)) {
        CustomSnackBarHelper.showCustomSnackbar(
          context,
          "Gender preference  entered is not valid.",
        );
      }
    }

    if (currentPageIndex == 4) {
      if (!UserInfoValidator.isLocationValid(context)) {
        CustomSnackBarHelper.showCustomSnackbar(
          context,
          "Location entered is not valid.",
        );
      }
    }

    if (currentPageIndex == 7) {
      if (!UserInfoValidator.isSocialHandleValid(context)) {
        CustomSnackBarHelper.showCustomSnackbar(
          context,
          "Social handle entered is not valid.",
        );
      }
    }
    if (currentPageIndex == _profileCreationData.length - 1) {
      if (context.mounted) {
        if (_onboardingHelperClass.allFieldsValid(context)) {
          Navigator.push(
            context,
            FadeRouteTransition(dest: const SelectProfilePictures()),
          );
        } else {
          CustomSnackBarHelper.showCustomSnackbar(
            context,
            "Please fill all the fields correctly before proceeding.",
          );
        }
      }
      return;
    }
    setState(() {
      _opacity = 0.0;
    });
    await Future.delayed(_fadeDuration);

    if (currentPageIndex < _profileCreationData.length - 1) {
      setState(() {
        currentPageIndex++;
        _opacity = 1.0;
      });
    }
  }

  void _goToPreviousPage() async {
    setState(() {
      _opacity = 0.0;
    });
    await Future.delayed(_fadeDuration);
    if (currentPageIndex >= 1) {
      currentPageIndex--;
    }
    setState(() {
      _opacity = 1.0; // reset opacity for fade in effect
    });
  }

  double _getAnimatedWidth() {
    final screenWidth = MediaQuery.of(context).size.width;
    final totalSteps = _profileCreationData.length;

    // Prevent division by zero and ensure smooth animation even when length is 0
    if (totalSteps == 0) return 0;

    // Calculate progress as a fraction between 0.0 and 1.0
    final progress = (currentPageIndex + 1) / totalSteps;

    return (screenWidth * 0.80) * progress;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.07),
              width: screenWidth * 0.85,
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.all(10),
                width: screenWidth * 0.13,
                height: screenWidth * 0.13,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.accentRed, width: 2),
                ),
                child: IconButton(
                  onPressed: () {
                    if (currentPageIndex == 0) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    } else {
                      _goToPreviousPage();
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.accentWhite,
                  ),
                  iconSize: 17,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            SizedBox(
              width: screenWidth * 0.80,
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _getAnimatedWidth(),
                  height: screenHeight * 0.01,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accentWhite, AppColors.accentRed],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: AnimatedOpacity(
                duration: _fadeDuration,
                opacity: _opacity,
                child:
                    _profileCreationData[currentPageIndex] ??
                    const CircularProgressIndicator(),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(bottom: 20, right: 20),
              width: screenWidth * 0.85,
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.all(10),
                width: screenWidth * 0.13,
                height: screenWidth * 0.13,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.accentRed, AppColors.accentWhite],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () => _goToNextPage(context),
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.accentWhite,
                  ),
                  iconSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
