import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:potential/core/configs/theme_extention.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/arena/cubit/bold_admirers_cubit.dart';
import 'package:potential/features/arena/widgets/bold_admirer_appreciation.dart';
import 'package:potential/features/home/helpers/home_card_popups.dart';
import 'package:potential/features/home/helpers/home_page_helper.dart';
import 'package:potential/features/home/services/card_data_service.dart';
import 'package:potential/features/home/widgets/user_badge_info.dart';
import 'package:potential/features/profile/helpers/question_card_helper.dart';
import 'package:potential/shared/widgets/back_button.dart';
import 'package:potential/shared/widgets/basic_card_layout.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoldAdmirerView extends StatefulWidget {
  const BoldAdmirerView({super.key, required this.user});
  final BoldAdmirerState user;

  @override
  State<BoldAdmirerView> createState() => _BoldAdmirerViewState();
}

class _BoldAdmirerViewState extends State<BoldAdmirerView> {
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
                // User Category
                widget.user.categoryLiked == "Soul"
                    ? BoldAdmirerAppreciation(
                        question: widget.user.question!,
                        answer: widget.user.answer!,
                        appreciation: widget.user.appreciation!,
                      )
                    : Container(
                        width: width * 0.9,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              CardDataService
                                  .cardData[widget.user.categoryLiked == "Soul"
                                  ? 3
                                  : widget.user.categoryLiked == "Spark"
                                  ? 0
                                  : widget.user.categoryLiked == "Mind"
                                  ? 1
                                  : 2]['cardStartColor'],
                              CardDataService
                                  .cardData[widget.user.categoryLiked == "Soul"
                                  ? 3
                                  : widget.user.categoryLiked == "Spark"
                                  ? 0
                                  : widget.user.categoryLiked == "Mind"
                                  ? 1
                                  : 2]['cardEndColor'],
                            ],
                          ),
                          borderRadius: BorderRadius.circular(width * 0.06),
                          border: Border.all(
                            color: AppColors.accentWhite,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.02),
                              child: SizedBox(
                                width: width * 0.6,
                                child: Text(
                                  "They've liked your ${widget.user.categoryLiked}.",
                                  style: TextStyle(
                                    color: AppColors.accentWhite,
                                    fontSize: width * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ),
                            SvgPicture.asset(
                              widget.user.assetPath,
                              width: width * 0.2,
                              height: width * 0.2,
                            ),
                          ],
                        ),
                      ),

                // User Name and Age
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "${widget.user.userModel.name}, ${widget.user.userModel.age}",
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
                            widget.user.userModel.profilePictures.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.all(width * 0.03),
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20,
                                  ),
                                  child: Image.network(
                                    widget
                                        .user
                                        .userModel
                                        .profilePictures[index],
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
                        count: widget.user.userModel.profilePictures.length,
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
                                  "Location": widget.user.userModel.location,
                                  "Education": widget.user.userModel.education,
                                  "Workplace":
                                      widget.user.userModel.workExperience,
                                  "Instagram":
                                      widget.user.userModel.socialMediaHandle,
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
                            isSoulCardUnlocked:
                                widget.user.userModel.soulUnlocked,
                            isSoulCard: index == 3,
                            overlayWidget: SizedBox.shrink(),
                            onCardTap: () => HomeCardPopups().showCardPopup(
                              context,
                              index,
                              cardData,
                              width,
                              height,
                              widget.user.userModel.soulUnlocked,
                              widget.user.userModel,
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: height * 0.02),
                      SizedBox(
                        width: width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: width * 0.2,
                          children: <Widget>[
                            Container(
                              width: width * 0.15,
                              height: width * 0.15,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.accentWhite,
                                    AppColors.accentRed,
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close_rounded,
                                  color: AppColors.accentWhite,
                                  size: width * 0.08,
                                ),
                              ),
                            ),
                            Container(
                              width: width * 0.15,
                              height: width * 0.15,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.accentWhite,
                                    AppColors.accentRed,
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.solidHeart,
                                  color: AppColors.accentWhite,
                                  size: width * 0.08,
                                ),
                              ),
                            ),
                          ],
                        ),
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
