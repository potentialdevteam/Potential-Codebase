import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class GuideUnlockSoul extends StatelessWidget {
  const GuideUnlockSoul({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: height * 0.02),
        Text(
          "UNLOCK SOUL",
          style: TextStyle(
            color: AppColors.soulYellow,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(height: height * 0.02),
        Text(
          "If you like a profile on the home page, you may showcase your interest by unlocking their soul (Similar to liking a profile). This can be done by clicking on the heart icon on any of the 3 cards on their profile which will show them that their profile has caught your eye, simultaneously unlocking their soul card for you to view.",
          style: TextStyle(color: AppColors.accentWhite),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.02),
        Text(
          "NOTE : YOU ONLY GET 5 LIKES PER DAY",
          style: TextStyle(
            color: AppColors.accentWhite,
            fontWeight: FontWeight.bold,
            // italics,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
