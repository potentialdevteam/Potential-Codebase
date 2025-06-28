import 'package:flutter/material.dart';
import 'package:potential/core/configs/theme_extention.dart';
import 'package:potential/core/constants/colors.dart';

class FirstMoveScreen extends StatelessWidget {
  const FirstMoveScreen({
    super.key,
    required this.matchedUserProfileUrl,
    required this.matchedUserName,
    required this.userProfileUrl,
    required this.firstMovePrompt,
  });
  final String matchedUserProfileUrl;
  final String matchedUserName;
  final String userProfileUrl;
  final String firstMovePrompt;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              spacing: height * 0.03,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // cross icon
                Container(
                  width: width * 0.85,
                  alignment: Alignment.centerLeft,
                  color: AppColors.bgBlack,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: AppColors.accentWhite,
                      size: width * 0.08,
                    ),
                  ),
                ),

                // matched user profile and user profile
                SizedBox(
                  width: width * 0.85,
                  height: height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: width * 0.85,
                        height: height * 0.3,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              right: width * 0.05,
                              child: Transform.rotate(
                                angle: 10 * 3.1415926535 / 180,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    width * 0.04,
                                  ),
                                  child: Image.network(
                                    userProfileUrl,
                                    width: width * 0.4,
                                    height: height * 0.25,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: width * 0.05,
                              child: Transform.rotate(
                                angle:
                                    -10 *
                                    3.1415926535 /
                                    180, // 20 degrees in radians
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    width * 0.04,
                                  ),
                                  child: Image.network(
                                    matchedUserProfileUrl,
                                    width: width * 0.4,
                                    height: height * 0.25,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "What a Match!",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: width * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "You've connected on a deeper level!\nYou may now get to know each other better.",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: width * 0.04,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // first move prompt
                Container(
                  width: width * 0.85,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    color: context.colors.grey,
                    borderRadius: BorderRadius.circular(width * 0.04),
                    border: Border.all(color: AppColors.accentRed, width: 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "$matchedUserName's First Move",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: width * 0.8,
                        height: height * 0.07,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.accentWhite,
                          borderRadius: BorderRadius.circular(width * 0.08),
                        ),
                        child: Text(
                          firstMovePrompt,
                          style: TextStyle(color: AppColors.bgBlack),
                        ),
                      ),
                    ],
                  ),
                ),

                // send message textfield
                Container(
                  width: width * 0.85,
                  color: Colors.transparent,
                  child: TextField(
                    cursorColor: AppColors.accentWhite,
                    style: TextStyle(color: AppColors.accentWhite),
                    decoration: InputDecoration(
                      hintText: "Send message...",
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      fillColor: AppColors.bgBlack,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.03,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.08),
                        borderSide: BorderSide(
                          color: AppColors.accentWhite,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.08),
                        borderSide: BorderSide(
                          color: AppColors.accentWhite,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.08),
                        borderSide: BorderSide(
                          color: AppColors.accentWhite,
                          width: 1,
                        ),
                      ),
                      suffixIcon: Container(
                        width: width * 0.07,
                        height: height * 0.07,
                        margin: EdgeInsets.only(right: width * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.send_rounded,
                            color: AppColors.accentWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
