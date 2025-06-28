import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potential/core/constants/colors.dart';

class GuideFourCards extends StatelessWidget {
  GuideFourCards({super.key});

  final List<Text> coloredText =
      "Each profile will be displaying their personality through the 4 cards going by the names of spark, mind, heart and soul."
          .split(" ")
          .map((word) {
            return Text(
              "$word ",
              style: TextStyle(
                color: word == "spark,"
                    ? AppColors.sparkPurple
                    : word == "mind,"
                    ? AppColors.mindBlue
                    : word == "heart"
                    ? AppColors.heartOrange
                    : word == "soul."
                    ? AppColors.soulYellow
                    : AppColors.accentRed,
              ),
            );
          })
          .toList();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "A Guide through Potential",
          style: TextStyle(
            color: AppColors.soulYellow,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        SizedBox(height: height * 0.02),
        SvgPicture.asset(
          "assets/svg/app_logo.svg",
          width: height * 0.05,
          height: height * 0.05,
        ),
        Text(
          "This is a very basic instruction manual to help you get started with Potential.",
          style: TextStyle(color: AppColors.accentWhite),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.02),
        Text(
          "THE 4 CARDS",
          style: TextStyle(
            color: AppColors.soulYellow,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        Wrap(alignment: WrapAlignment.center, children: coloredText),
        SizedBox(height: height * 0.02),
        Text(
          "By clicking on the card displayed on the home page, you can get a deeper understanding of the user.",
          style: TextStyle(color: AppColors.accentWhite),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
