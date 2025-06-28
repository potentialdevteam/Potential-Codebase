import 'package:flutter/material.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/onboarding/views/confirm_code.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/back_button.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.8,
          child: Column(
            spacing: screenHeight * 0.03,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Icon
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.1),
                width: screenWidth * 0.85,
                alignment: Alignment.centerLeft,
                child: BackButtonWidget(addPadding: false),
              ),

              Expanded(
                child: Column(
                  spacing: screenHeight * 0.02,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.85,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.85,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Don't Worry! Enter your email address and we will send you a code to reset your password.",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    OnboardingTextfield(
                      labelText: "Email Address",
                      hintText: "example@gmail.com",
                      keyboardType: TextInputType.emailAddress,
                    ),

                    // SignInButton
                    Hero(
                      tag: "signInButtonWelcomeScreen",
                      child: OnboardingButton(
                        onPressed: () => Navigator.push(
                          context,
                          FadeRouteTransition(dest: ConfirmCodeScreen()),
                        ),
                        text: "Send Code",
                      ),
                    ),
                  ],
                ),
              ),
              // Main Content
            ],
          ),
        ),
      ),
    );
  }
}
