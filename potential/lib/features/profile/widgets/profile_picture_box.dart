import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:potential/core/constants/colors.dart';

class ProfilePictureBox extends StatelessWidget {
  final File? image;
  final VoidCallback onPressed;
  final VoidCallback? onRemove;

  const ProfilePictureBox({
    super.key,
    this.image,
    required this.onPressed,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onPressed,
      child: DottedBorder(
        options: RectDottedBorderOptions(
          strokeWidth: 1,
          dashPattern: const [5, 5],
          color: AppColors.accentWhite,
        ),
        child: Container(
          width: screenWidth * 0.35,
          height: screenWidth * 0.35,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: image != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: onRemove, // 👈 Trigger removal
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            // color: AppColors.accentRed,
                            gradient: LinearGradient(
                              colors: <Color>[
                                AppColors.accentRed,
                                AppColors.accentWhite,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Icon(Icons.add_circle_outlined, color: AppColors.accentRed),
        ),
      ),
    );
  }
}
