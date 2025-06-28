import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class LockedSoulCardPopup extends StatelessWidget {
  const LockedSoulCardPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Does, 32",
                style: TextStyle(
                  color: AppColors.accentWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.05,
                ),
                decoration: BoxDecoration(
                  color: AppColors.soulYellow,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.accentWhite, width: 2.0),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "To unlock the Soul Card,\nYou must like one of their cards first.",
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.accentWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        color: AppColors.bgBlack,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
