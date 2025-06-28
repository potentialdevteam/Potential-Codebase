import 'package:flutter/material.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/profile/views/upgrade_potential.dart';
import 'package:potential/core/constants/colors.dart';

class PotentialElevated extends StatelessWidget {
  const PotentialElevated({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.9,
      height: height * 0.2,
      margin: EdgeInsets.only(top: height * 0.02),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.bgBlack, const Color.fromARGB(255, 90, 10, 16)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accentRed, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: height * 0.01,
        children: [
          Text(
            "Potential Elevated",
            style: TextStyle(
              color: AppColors.accentWhite,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "A premium user demands a premium experience.",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              FadeRouteTransition(dest: UpgradePotential()),
            ),
            child: Container(
              width: width * 0.5,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentWhite.withAlpha(50),
                    spreadRadius: 5,
                    blurRadius: 30,
                  ),
                ],
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 7,
                  focalRadius: 10,
                  colors: [AppColors.accentRed, AppColors.accentWhite],
                ),
              ),
              child: Center(
                child: Text(
                  "Upgrade Now",
                  style: TextStyle(
                    color: AppColors.accentWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                    fontFamily: "Vastago Grotesk",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
