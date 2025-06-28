import 'package:flutter/material.dart';
import 'package:potential/features/onboarding/widgets/onboarding_button.dart';
import 'package:potential/features/onboarding/widgets/onboarding_textfield.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/onboarding/views/confirm_code.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/back_button.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
                        "Reset Password",
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
                        "Use a password you won't forget this time.",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    OnboardingTextfield(
                      labelText: "New Password",
                      hintText: "must be 8 charachters",
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      onChanged: (value) {
                        // Handle password change
                      },
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: AppColors.accentWhite,
                      ),
                    ),

                    OnboardingTextfield(
                      labelText: "Confirm Password",
                      hintText: "Repear your password",
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      onChanged: (value) {
                        // Handle password change
                      },
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: AppColors.accentWhite,
                      ),
                    ),

                    // SignInButton
                    Hero(
                      tag: "signInButtonWelcomeScreen",
                      child: OnboardingButton(
                        onPressed: () => Navigator.push(
                          context,
                          FadeRouteTransition(dest: ConfirmCodeScreen()),
                        ),
                        text: "Reset",
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
