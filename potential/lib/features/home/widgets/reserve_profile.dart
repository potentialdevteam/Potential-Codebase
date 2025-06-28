import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class GuideReserveProfile extends StatelessWidget {
  const GuideReserveProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: height * 0.02),
        Text(
          "RESERVE PROFILE (COMING SOON)",
          style: TextStyle(
            color: AppColors.soulYellow,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.02),
        Text(
          "If you seem to be unsure about a profile and do not wish to unlock their soul or even reject them, you may hold on the profile with the reserve feature, giving you additional 24 hours to make up your mind.",
          style: TextStyle(color: AppColors.accentWhite),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.02),
        Text(
          "NOTE : YOU ONLY GET 5 RESERVES PER DAY.",
          style: TextStyle(
            color: AppColors.accentWhite,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.02),
        Text(
          "Enjoy the journey of self-discovery and connection!",
          style: TextStyle(color: AppColors.soulYellow),
        ),
      ],
    );
  }
}
