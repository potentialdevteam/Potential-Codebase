import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class ProfileVerificationInfoPage extends StatelessWidget {
  const ProfileVerificationInfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: Center(
        child: Column(
          children: [
            // icon to back
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
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: screenWidth * 0.8,
                  child: Column(
                    spacing: screenHeight * 0.02,
                    children: [
                      Image(
                        image: const AssetImage("assets/images/nick.jpg"),
                        width: screenWidth * 0.80,
                        height: screenHeight * 0.40,
                      ),
                      Text(
                        "Why a \n Selfie Verification?",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Real Faces.\n Real Connections",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      Text(
                        "We believe in authenticity.\nThat's why we ask every user to verify with a quick selfie, it's how we make sure you're expressing yourself with other real people, no catfishes or bots. Your selfie is never shown publicly. It's only for trust and safety!",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Image(
                        image: const AssetImage(
                          "assets/images/couple_selfie.jpg",
                        ),
                        width: screenWidth * 0.80,
                        height: screenHeight * 0.40,
                      ),
                      Text(
                        "Tips to make sure you capture a perfect selfie",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      Text(
                        "-Find some natural light.\n-Make sure your face is clearly visible (no filters, sunglasses or group shots)\nMatch the pose you'll see on the screen since it helps our system verify faster.",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Image(
                        image: const AssetImage(
                          "assets/images/group_selfie.jpg",
                        ),
                        width: screenWidth * 0.80,
                        height: screenHeight * 0.40,
                      ),
                      Text(
                        "Be the reason someone feels safe here.\nEvery verified user adds a layer of trust to this space.",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      Text(
                        "By verifying your profile, you're helping us create a community where honesty wins, and everyone feels secure being themselves.",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                    ],
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
