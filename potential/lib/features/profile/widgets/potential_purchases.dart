import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class PotentialPurchases extends StatelessWidget {
  final String purchaseName;
  final int purchaseCountAvailable;
  final IconData purchaseIcon;
  const PotentialPurchases({
    super.key,
    required this.purchaseName,
    required this.purchaseCountAvailable,
    required this.purchaseIcon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(width * 0.02),
          width: width * 0.25,
          height: width * 0.25,
          padding: EdgeInsets.all(width * 0.02),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accentRed, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(purchaseIcon, color: AppColors.accentRed),
              Text(
                "$purchaseCountAvailable $purchaseName",
                style: TextStyle(fontSize: 10, color: AppColors.accentWhite),
              ),
              Text(
                "Get More",
                style: TextStyle(fontSize: 10, color: AppColors.accentWhite),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accentRed, AppColors.accentWhite],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: AppColors.accentWhite),
            ),
          ),
        ),
      ],
    );
  }
}
