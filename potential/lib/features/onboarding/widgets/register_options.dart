import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potential/features/onboarding/widgets/register_button.dart';
import 'package:potential/core/services/google_service.dart';
import 'package:potential/core/constants/colors.dart';

class RegisterOptions extends StatefulWidget {
  final String text;
  final String task;
  const RegisterOptions({required this.text, required this.task, super.key});

  @override
  State<RegisterOptions> createState() => _RegisterOptionsState();
}

class _RegisterOptionsState extends State<RegisterOptions> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Seperator
        SizedBox(
          width: screenWidth * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: screenWidth * 0.25,
                height: 1.5,
                color: AppColors.accentWhite,
              ),
              Text(
                "Or ${widget.text} with",
                style: TextStyle(color: AppColors.accentWhite),
              ),
              Container(
                width: screenWidth * 0.25,
                height: 1.5,
                color: AppColors.accentWhite,
              ),
            ],
          ),
        ),

        // Extra Space
        SizedBox(height: screenWidth * 0.05),

        // Social Media Buttons
        SizedBox(
          width: screenWidth * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RegisterButton(
                svgIcon: SvgPicture.asset(
                  "assets/svg/google_icon.svg",
                  width: screenWidth * 0.06,
                ),
                onTap: () {
                  if (widget.task == "create") {
                    // create account with google
                    GoogleAuthClass().createUserWithGoogle(context);
                  }
                  if (widget.task == "signin") {
                    // sign in with google
                    GoogleAuthClass().signInWithGoogle(context);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
