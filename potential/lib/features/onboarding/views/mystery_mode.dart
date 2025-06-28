import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class MysterModePage extends StatelessWidget {
  const MysterModePage({super.key});

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
                        image: const AssetImage(
                          "assets/images/couple_sunset.jpg",
                        ),
                        width: screenWidth * 0.80,
                        height: screenHeight * 0.40,
                      ),
                      Text(
                        "What is\n Mystery Mode",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "You Control\n Who Sees you!",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "In India, privacy matters, especially when it comes to dating. That's why we created Mystery Mode.",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "With this feature, if you have selected multiple profile pictures, only 1 will be shown and rest will stay hidden from everyone except those you've shown interest in. Until then, your remaining pictures stays blurred.",
                        style: TextStyle(
                          color: AppColors.accentRed,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "your choice, your control",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Image(
                        image: const AssetImage(
                          "assets/images/hearts_window.jpg",
                        ),
                        width: screenWidth * 0.80,
                        height: screenHeight * 0.40,
                      ),
                      Text(
                        "Mystery Mode is designed to create a safer, more respectful space, especially for women who prefer meaningful matches over endless exposure. It's about taking the pressure of, and putting your comfort first. Mystery Mode gives you the freedom to be more intentional while still building genuine, meaningful connections.",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Just remember, this will not hide your photos forever, they will be revealed to the user when the two of you match and before you end up chatting.",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
