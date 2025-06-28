import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/home/helpers/home_card_popups.dart';
import 'package:potential/features/home/models/user_model.dart';

class CardQuestionPopupWidget extends StatelessWidget {
  CardQuestionPopupWidget({
    super.key,
    required this.questions,
    required this.title,
    required this.assetPath,
    this.isSoulCard = false,
    this.user,
    this.showAppreciationIcon = false,
  });
  final Map<String, String> questions;
  final String title;
  final String assetPath;
  bool? isSoulCard;
  UserModel? user;
  bool? showAppreciationIcon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * 0.7,
      height: height * 0.5,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Card Title and SVG
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.1,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentWhite,
                    ),
                  ),
                  SvgPicture.asset(
                    assetPath,
                    width: width * 0.1,
                    height: width * 0.1,
                  ),
                ],
              ),

              // Questions and Answers
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(questions.length, (index) {
                  final questionAnswerMap = questions.entries.elementAt(index);
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questionAnswerMap.key,
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: AppColors.accentWhite,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          questionAnswerMap.value,
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: AppColors.accentWhite,
                          ),
                        ),
                        if (isSoulCard == true && showAppreciationIcon == true)
                          Container(
                            width: width * 0.075,
                            height: width * 0.075,
                            margin: EdgeInsets.symmetric(
                              vertical: height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentWhite,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              alignment: Alignment.center,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                HomeCardPopups().showSoulChatPopup(
                                  context,
                                  user!.name,
                                  user!.age.toString(),
                                  title,
                                  questionAnswerMap.key,
                                  questionAnswerMap.value,
                                );
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.commentDots,
                                color: AppColors.bgBlack,
                                size: width * 0.05,
                              ),
                            ),
                          ),
                        Divider(
                          color: AppColors.accentWhite.withAlpha(100),
                          thickness: 1,
                          height: 1,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
