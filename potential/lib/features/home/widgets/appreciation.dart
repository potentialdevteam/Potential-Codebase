import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class GuideAppreciation extends StatelessWidget {
  const GuideAppreciation({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: height * 0.02),
        Text(
          "APPRECIATION",
          style: TextStyle(
            color: AppColors.soulYellow,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(height: height * 0.02),
        Text(
          "After having unlocked a user's soul, if you wish to make your profile stand out to them and showcase your deeper interest, you may use the Appreciation feature to comment on the answers in thier soul section.",
          style: TextStyle(color: AppColors.accentWhite),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.02),
        Text(
          "NOTE : YOU ONLY GET 2 APPRECIATIONS PER DAY.",
          style: TextStyle(
            color: AppColors.accentWhite,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),

          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
