import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:potential/features/profile/widgets/profile_picture_box.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/core/configs/fade_route_transition.dart';
import 'package:potential/features/onboarding/views/mystery_mode.dart';
import 'package:potential/features/onboarding/views/verify_profile.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';

class SelectProfilePictures extends StatefulWidget {
  const SelectProfilePictures({super.key});

  @override
  State<SelectProfilePictures> createState() => SelectProfilePicturesState();
}

class SelectProfilePicturesState extends State<SelectProfilePictures> {
  void selectImage(BuildContext context, String? file) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (!context.mounted) return;

    if (file != null && image != null) {
      final String newImage = image.path;
      context.read<CreateAccountCubit>().updateSelectedImages(file, newImage);
    } else if (image != null && file == null) {
      final String newImage = image.path;
      context.read<CreateAccountCubit>().addImage(newImage);
    }
  }

  void removeImage(BuildContext context, String image) {
    context.read<CreateAccountCubit>().removeImage(image);
  }

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pick your pictures!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Select up to 3 pictures that best represent you. Use clear, high-quality images for the best results.",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                            BlocBuilder<CreateAccountCubit, CreateAccountData>(
                              builder: (context, state) {
                                final screenWidth = MediaQuery.of(
                                  context,
                                ).size.width;
                                final profilePictures = state.profilePicture;

                                return Row(
                                  children: [
                                    ...profilePictures.map((file) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right: screenWidth * 0.05,
                                        ),
                                        child: ProfilePictureBox(
                                          image: File(file),
                                          onPressed: () =>
                                              selectImage(context, file),
                                          onRemove: () =>
                                              removeImage(context, file),
                                        ),
                                      );
                                    }),
                                    // limit the number of pictures to 3
                                    if (profilePictures.length < 3)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: screenWidth * 0.05,
                                        ),
                                        child: ProfilePictureBox(
                                          onPressed: () =>
                                              selectImage(context, null),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Text>[
                        Text(
                          "Tap To Change Picture",
                          style: TextStyle(
                            color: AppColors.accentWhite,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "At most 3 pictures will be displayed",
                          style: TextStyle(
                            color: AppColors.accentWhite,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      spacing: screenWidth * 0.02,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        BlocBuilder<CreateAccountCubit, CreateAccountData>(
                          builder: (context, state) {
                            return Checkbox(
                              activeColor: AppColors.accentRed,
                              value: state.mysteryModeEnabled,
                              onChanged: (bool? value) {
                                context
                                    .read<CreateAccountCubit>()
                                    .updateMysteryModeEnabled(value ?? false);
                              },
                            );
                          },
                        ),
                        Text(
                          "Mystery Mode",
                          style: TextStyle(
                            color: AppColors.accentRed,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            FadeRouteTransition(dest: MysterModePage()),
                          ),
                          child: Text(
                            "Learn More",
                            style: TextStyle(
                              color: AppColors.accentWhite,
                              fontSize: 10,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.accentWhite,
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                    onPressed: () {
                      List<String> images = context
                          .read<CreateAccountCubit>()
                          .state
                          .profilePicture;
                      if (images.isEmpty) {
                        CustomSnackBarHelper.showCustomSnackbar(
                          context,
                          "Please select at least one picture.",
                        );
                      } else {
                        Navigator.push(
                          context,
                          FadeRouteTransition(dest: VerifyProfileScreen()),
                        );
                      }
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
