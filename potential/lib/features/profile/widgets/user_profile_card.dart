import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potential/core/constants/colors.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    super.key,
    required this.width,
    required this.height,
    this.cardTitle,
    this.cardSubtitle,
    this.cardIcon,
    this.cardStartColor = const Color.fromARGB(255, 137, 27, 170),
    this.cardEndColor = const Color.fromARGB(255, 137, 27, 170),
    this.progressColor = Colors.white,
    this.progressValue = 0.0,
    this.progressText = "0%",
    this.isSoulCard = false,
    this.onTap,
  });

  final double width;
  final double height;
  final String? cardTitle;
  final String? cardSubtitle;
  final String? cardIcon;
  final Color? cardStartColor;
  final Color? cardEndColor;
  final Color? progressColor;
  final double? progressValue;
  final String? progressText;
  final bool? isSoulCard;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          shadowColor: Colors.blueGrey,
          child: Container(
            width: width * 0.85,
            height: height * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  cardStartColor ?? AppColors.sparkPurple,
                  cardEndColor ?? AppColors.sparkPurple,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  right: 10,
                  child: SvgPicture.asset(
                    cardIcon ?? "assets/svg/spark_card.svg",
                    height: isSoulCard! ? height * 0.1 : height * 0.15,
                    width: isSoulCard! ? height * 0.1 : height * 0.15,
                  ),
                ),
                Positioned(
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cardTitle ?? "Spark",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cardSubtitle ?? "Vibe.Energy.Chemistry",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: width * 0.15,
                    height: width * 0.15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentWhite,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: progressColor ?? AppColors.sparkPurple,
                          value: progressValue ?? 0.3,
                          strokeWidth: 1,
                          padding: EdgeInsets.all(5),
                        ),
                        Text(progressText ?? "30%"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
