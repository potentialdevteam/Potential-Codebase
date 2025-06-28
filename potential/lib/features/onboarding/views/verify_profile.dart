import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:potential/core/configs/theme_extention.dart';
import 'package:potential/features/auth/cubits/auth.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/onboarding/helpers/onboarding_helper.dart';
import 'package:potential/features/home/views/layout.dart';
import 'package:potential/features/onboarding/views/profile_verification.dart';
import 'package:potential/core/constants/colors.dart';

class VerifyProfileScreen extends StatelessWidget {
  const VerifyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: Column(
            spacing: MediaQuery.of(context).size.height * 0.02,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Icon button to go back
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.07),
                width: screenWidth * 0.80,
                alignment: Alignment.centerLeft,
                child: Container(
                  width: screenWidth * 0.13,
                  height: screenWidth * 0.13,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.accentRed, width: 2),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.accentWhite,
                    ),
                    iconSize: 17,
                  ),
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: screenWidth * 0.80,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      spacing: screenHeight * 0.05,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Verify your profile by taking a selfie.",
                          style: TextStyle(
                            color: AppColors.accentWhite,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            FadeRouteTransition(
                              dest: ProfileVerificationInfoPage(),
                            ),
                          ),
                          child: Container(
                            width: screenWidth * 0.80,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Learn More",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.accentRed,
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.accentRed,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                        ),
                        DottedBorder(
                          options: CircularDottedBorderOptions(
                            strokeWidth: 1,
                            dashPattern: const [10, 10],
                            color: AppColors.accentRed,
                          ),
                          child:
                              BlocBuilder<
                                CreateAccountCubit,
                                CreateAccountData
                              >(
                                builder: (context, state) => GestureDetector(
                                  onTap: () async {
                                    final ImagePicker picker = ImagePicker();
                                    XFile? verificationImage = await picker
                                        .pickImage(source: ImageSource.camera);

                                    if (context.mounted &&
                                        verificationImage != null) {
                                      String image = verificationImage.path;
                                      context
                                          .read<CreateAccountCubit>()
                                          .setVerificationImage(image);
                                    }
                                  },
                                  child: Container(
                                    width: screenWidth * 0.7,
                                    height: screenWidth * 0.7,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.colors.grey,
                                    ),
                                    child: state.verificationImage != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              screenWidth * 0.7,
                                            ),
                                            child: Image.file(
                                              File(state.verificationImage!),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          )
                                        : Icon(
                                            Icons.camera_alt_outlined,
                                            color: AppColors.accentWhite,
                                            size: screenWidth * 0.1,
                                          ),
                                  ),
                                ),
                              ),
                        ),
                        Text(
                          "Here's a tip : Take a clear picture and show your smile. You can retake the picture by tapping on the image.",
                          style: TextStyle(
                            color: AppColors.accentWhite,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Icon Button To Proceed
              Container(
                padding: const EdgeInsets.only(bottom: 20, right: 10),
                width: screenWidth * 0.80,
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: screenWidth * 0.13,
                  height: screenWidth * 0.13,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accentRed, AppColors.accentWhite],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      context.read<AuthCubit>().updateAuthData(
                        email: context.read<CreateAccountCubit>().state.email,
                        uid: context.read<CreateAccountCubit>().state.uid,
                        isLoggedIn: true,
                      );
                      OnboardingHelperClass().updateAge(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        FadeRouteTransition(dest: HomeLayout()),
                        (route) => false,
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.accentWhite,
                    ),
                    iconSize: 17,
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
