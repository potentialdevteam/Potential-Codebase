import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class CustomSnackBarHelper {
  static void showCustomSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.accentRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        showCloseIcon: true,
        closeIconColor: AppColors.accentWhite,
        content: Text(text, style: TextStyle(color: AppColors.accentWhite)),
      ),
    );
  }
}
