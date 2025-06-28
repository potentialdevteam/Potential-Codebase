import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class GuideYourPotential extends StatelessWidget {
  const GuideYourPotential({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: height * 0.02),
        Text(
          "YOUR POTENTIAL",
          style: TextStyle(
            color: AppColors.soulYellow,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(height: height * 0.02),
        Text(
          "Love is not only about finding the right person, but also about being the right person. The \"Your Potential\" section provides you with basic tips, reminders, practices and preaches that enhance your chances of having a better relationship and thereafter growing together.",
          style: TextStyle(color: AppColors.accentWhite),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
