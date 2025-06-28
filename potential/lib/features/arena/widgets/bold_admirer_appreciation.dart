import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/home/services/card_data_service.dart';

class BoldAdmirerAppreciation extends StatelessWidget {
  const BoldAdmirerAppreciation({
    required this.question,
    required this.answer,
    required this.appreciation,
    super.key,
  });

  final String question;
  final String answer;
  final String appreciation;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
      height: height * 0.3,
      padding: EdgeInsets.all(width * 0.02),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CardDataService.cardData[3]['cardStartColor'],
            CardDataService.cardData[3]['cardEndColor'],
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(width * 0.06),
        border: Border.all(color: AppColors.accentWhite, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                question,
                style: TextStyle(
                  color: AppColors.accentWhite,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SvgPicture.asset(
                CardDataService.cardData[3]['cardIcon'],
                width: width * 0.12,
                height: width * 0.12,
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
          Text(
            answer,
            style: TextStyle(
              color: AppColors.accentWhite,
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            width: width * 0.9,
            height: height * 0.1,
            decoration: BoxDecoration(
              color: AppColors.accentWhite,
              borderRadius: BorderRadius.circular(width * 0.06),
            ),
            child: Center(
              child: Text(
                appreciation,
                style: TextStyle(
                  color: AppColors.bgBlack,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
