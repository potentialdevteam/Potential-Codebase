import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class BasicCardModel {
  final String cardTitle;
  final String cardDescription;
  final String cardAssetPath;
  final List<Color> cardGradientColors;
  final Color? progressColor;

  BasicCardModel({
    required this.cardTitle,
    required this.cardDescription,
    required this.cardAssetPath,
    required this.cardGradientColors,
    this.progressColor = AppColors.sparkPurple,
  });
}
