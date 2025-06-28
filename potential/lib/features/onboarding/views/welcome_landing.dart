import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/onboarding/widgets/register_options.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/onboarding/views/create_account.dart';
import 'package:potential/features/onboarding/views/signin.dart';
import 'package:potential/core/constants/colors.dart';

class WelcomeLanding extends StatefulWidget {
  const WelcomeLanding({super.key});

  @override
  State<WelcomeLanding> createState() => _WelcomeLandingState();
}

class _WelcomeLandingState extends State<WelcomeLanding> {
  void _goToSignIn() {
    Navigator.push(context, FadeRouteTransition(dest: const SignInPage()));
  }

  void _goToCreateAccount() {
    Navigator.push(
      context,
      FadeRouteTransition(dest: const CreateAccountPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenWidth * 0.9,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.6,
                        height: screenWidth * 0.3,
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
                        child: SvgPicture.asset(
                          'assets/svg/app_logo.svg',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),

                  // Text Below Logo
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Text>[
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accentWhite,
                          ),
                        ),
                        Text(
                          "Get Started with Potential",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.accentWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenWidth * 0.1),
            // Buttons to create account or sign in
            Container(
              width: screenWidth * 0.9,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: screenWidth * 0.02,
                children: <Widget>[
                  GestureDetector(
                    onTap: _goToCreateAccount,
                    child: Container(
                      width: screenWidth * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.bgBlack,
                        border: Border.all(
                          color: AppColors.accentWhite,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            color: AppColors.accentWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'or',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Hero(
                    tag: "signInButtonWelcomeScreen",
                    child: OnboardingButton(
                      onPressed: _goToSignIn,
                      text: "Sign In",
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenWidth * 0.2),

            RegisterOptions(text: "register", task: "check_user"),
          ],
        ),
      ),
    );
  }
}
