import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/constants/colors.dart';

class UserProfilePictureCompletion extends StatelessWidget {
  const UserProfilePictureCompletion({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
  });

  final double width;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.34,
        height: width * 0.34,
        margin: EdgeInsets.only(top: height * 0.02),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.accentRed.withAlpha(100),
              blurRadius: 15,
              offset: Offset(0, 10),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            BlocBuilder<CreateAccountCubit, CreateAccountData>(
              builder: (context, state) {
                return CircleAvatar(
                  radius: width * 0.15,
                  backgroundImage: state.profilePicture.isNotEmpty
                      ? FileImage(
                          File(
                            context
                                .watch<CreateAccountCubit>()
                                .state
                                .profilePicture
                                .first,
                          ),
                        )
                      : NetworkImage(
                          "https://thumbs.dreamstime.com/b/profile-picture-young-indian-woman-renter-headshot-portrait-confident-tenant-pose-modern-own-new-apartment-house-226719004.jpg",
                        ),
                );
              },
            ),
            SizedBox(
              width: width * 0.31,
              height: width * 0.31,
              child: RotatedBox(
                quarterTurns: 2,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: AppColors.accentRed,
                  value: 0.75,
                  strokeWidth: 4.0,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: AppColors.accentWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "75%",
                  style: TextStyle(
                    color: AppColors.bgBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
