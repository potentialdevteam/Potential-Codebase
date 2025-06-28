import 'package:flutter/material.dart';
import 'package:potential/core/configs/theme_extention.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/home/helpers/home_card_popups.dart';
import 'package:potential/features/home/helpers/home_page_helper.dart';
import 'package:potential/features/home/models/user_model.dart';
import 'package:potential/features/home/services/card_data_service.dart';
import 'package:potential/features/home/widgets/user_badge_info.dart';
import 'package:potential/features/profile/helpers/question_card_helper.dart';
import 'package:potential/shared/widgets/back_button.dart';
import 'package:potential/shared/widgets/basic_card_layout.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ChosenFewUserView extends StatefulWidget {
  const ChosenFewUserView({super.key, required this.user});
  final UserModel user;

  @override
  State<ChosenFewUserView> createState() => _ChosenFewUserViewState();
}

class _ChosenFewUserViewState extends State<ChosenFewUserView> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        foregroundColor: AppColors.accentWhite,
        title: GradientText(
          "Arena!",
          style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
          colors: [AppColors.accentWhite, AppColors.accentRed],
        ),
        centerTitle: true,
        leading: BackButtonWidget(),
      ),
      body: Center(
        child: Container(
          height: height * 0.85,
          width: width * 0.9,
          color: AppColors.bgBlack,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // User Name and Age
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "${widget.user.name}, ${widget.user.age}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentWhite,
                      fontSize: width * 0.06,
                    ),
                  ),
                ),

                // User Profile Pictures
                Container(
                  height: width * 0.9,
                  width: width * 0.9,
                  color: AppColors.bgBlack,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: PageView(
                          controller: PageController(),
                          pageSnapping: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            widget.user.profilePictures.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.all(width * 0.03),
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20,
                                  ),
                                  child: Image.network(
                                    widget.user.profilePictures[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        effect: WormEffect(
                          dotHeight: 5,
                          dotWidth: 5,
                          activeDotColor: AppColors.accentRed,
                          dotColor: AppColors.accentWhite,
                        ),
                        controller: pageController,
                        count: widget.user.profilePictures.length,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),
                // User Voice Prompt
                Container(
                  height: height * 0.1,
                  width: width * 0.85,
                  color: AppColors.bgBlack,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Placeholder for Voice Prompt
                        Expanded(
                          child: Container(
                            color: Colors.red,
                            child: Center(child: Text("Voice Prompt Here")),
                          ),
                        ),

                        // USER BADGE
                        InkWell(
                          splashColor: Colors.redAccent,
                          onTap: () async {
                            await HomePageHelper().showPopUpWidget(
                              widget: UserBadgeInfo(
                                userInfo: {
                                  "Location": widget.user.location,
                                  "Education": widget.user.education,
                                  "Workplace": widget.user.workExperience,
                                  "Instagram": widget.user.socialMediaHandle,
                                },
                              ),
                              wrapperHeight: height * 0.55,
                              wrapperWidth: width * 0.8,
                              context: context,
                              borderColor: AppColors.accentWhite,
                              backgroundColor: AppColors.bgBlack.withAlpha(100),
                              isBackDropFilter: true,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(height * 0.01),
                            decoration: BoxDecoration(
                              color: AppColors.accentWhite,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.redAccent.withAlpha(150),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(
                                    0,
                                    3,
                                  ), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/images/badge_icon.png",
                              width: height * 0.06,
                              height: height * 0.06,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // CARDS AND ACTIONS
                Container(
                  height: height * 0.9,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: context.colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      // 4 USER CARDS
                      Column(
                        children: List.generate(4, (index) {
                          final cardData = CardDataService.cardData[index];
                          return BasicCardLayout(
                            cardModel: CardsHelperClass.cardModelS[index],
                            isSoulCardUnlocked: widget.user.soulUnlocked,
                            isSoulCard: index == 3,
                            overlayWidget: SizedBox.shrink(),
                            onCardTap: () => HomeCardPopups().showCardPopup(
                              context,
                              index,
                              cardData,
                              width,
                              height,
                              widget.user.soulUnlocked,
                              widget.user,
                              showAppreciationIcon: true,
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        "To initiate chat, wait for them to match with you!",
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: width * 0.04,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
