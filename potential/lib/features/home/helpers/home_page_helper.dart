import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class HomePageHelper {
  Future<void> showPopUpWidget({
    required Widget widget,
    required BuildContext context,
    required Color borderColor,
    Color? backgroundColor,
    List<Color>? buttonGradientColors,
    double? wrapperWidth,
    double? wrapperHeight,
    List<Color>? gradientColors,
    bool? isBackDropFilter,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: backgroundColor ?? Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(30),
            child: BackdropFilter(
              filter: isBackDropFilter == true
                  ? ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0)
                  : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
              child: Container(
                width: wrapperWidth ?? MediaQuery.of(context).size.width * 0.8,
                height:
                    wrapperHeight ?? MediaQuery.of(context).size.height * 0.65,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: gradientColors != null
                      ? LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: gradientColors != null
                      ? backgroundColor
                      : AppColors.bgBlack.withAlpha(50),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    widget,
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors:
                                buttonGradientColors ??
                                <Color>[
                                  AppColors.accentRed,
                                  AppColors.accentRed,
                                ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
