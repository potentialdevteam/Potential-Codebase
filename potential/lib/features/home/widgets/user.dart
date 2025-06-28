import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:potential/core/configs/theme_extention.dart';
import 'package:potential/features/arena/cubit/chosen_few_cubit.dart';
import 'package:potential/features/home/helpers/home_card_popups.dart';
import 'package:potential/features/home/models/user_model.dart';
import 'package:potential/features/home/services/card_data_service.dart';
import 'package:potential/features/home/widgets/user_action.dart';
import 'package:potential/features/home/helpers/home_page_helper.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/features/home/widgets/user_badge_info.dart';
import 'package:potential/features/profile/helpers/question_card_helper.dart';
import 'package:potential/shared/widgets/basic_card_layout.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swipable_stack/swipable_stack.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    super.key,
    required this.swipeController,
    required this.userModel,
  });
  final SwipableStackController? swipeController;

  final UserModel userModel;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final HomePageHelper homePageHelper = HomePageHelper();

  final PageController pageController = PageController();

  // bool isSoulCardUnlocked = false;

  void onLikeTap(BuildContext context, UserModel user) {
    //
    user.soulUnlocked = true;
    context.read<ChosenFewCubit>().addUser(user);
    widget.swipeController?.next(
      swipeDirection: SwipeDirection.left,
      duration: const Duration(milliseconds: 400),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
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
                "${widget.userModel.name}, ${widget.userModel.age}",
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
                      controller: pageController,
                      pageSnapping: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        widget.userModel.profilePictures.length,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.all(width * 0.03),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaX:
                                          (widget.userModel.mysteryMode &&
                                              index != 0)
                                          ? 20
                                          : 0,
                                      sigmaY:
                                          (widget.userModel.mysteryMode &&
                                              index != 0)
                                          ? 20
                                          : 0,
                                    ),
                                    child: Image.network(
                                      widget.userModel.profilePictures[index],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      (widget.userModel.mysteryMode &&
                                      index != 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      color: AppColors.bgBlack.withAlpha(50),
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                                if (widget.userModel.mysteryMode && index != 0)
                                  _buildLockedOverlay(width, height),
                              ],
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
                    count: widget.userModel.profilePictures.length,
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
                              "Location": widget.userModel.location,
                              "Education": widget.userModel.education,
                              "Workplace": widget.userModel.workExperience,
                              "Instagram": widget.userModel.socialMediaHandle,
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
                        margin: EdgeInsets.all(height * 0.005),
                        padding: EdgeInsets.all(height * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              colors: [
                                AppColors.accentRed,
                                AppColors.accentWhite,
                              ],
                            ).createShader(bounds);
                          },
                          child: FaIcon(
                            FontAwesomeIcons.idBadge,
                            color: AppColors.accentWhite,
                            size: height * 0.06,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // CARDS AND ACTIONS
            Container(
              height: height,
              width: width * 0.9,
              decoration: BoxDecoration(
                color: context.colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: <Widget>[
                  // 4 USER CARDS
                  Column(
                    children: List.generate(4, (index) {
                      final cardData = CardDataService.cardData[index];
                      return BasicCardLayout(
                        cardModel: CardsHelperClass.cardModelS[index],
                        isSoulCardUnlocked: widget.userModel.soulUnlocked,
                        isSoulCard: index == 3,
                        overlayWidget: Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            width: width * 0.15,
                            height: width * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  widget.userModel.soulUnlocked == false &&
                                      index == 3
                                  ? null
                                  : AppColors.accentWhite,
                            ),
                            child: Center(
                              child:
                                  widget.userModel.soulUnlocked == false &&
                                      index == 3
                                  ? Text(
                                      "Locked.",
                                      style: TextStyle(
                                        color: AppColors.accentWhite,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () =>
                                          HomeCardPopups().showLikePopup(
                                            context,
                                            cardData['cardTitle'],
                                            widget.userModel.name,
                                            widget.userModel.age.toString(),
                                            (_) {
                                              onLikeTap(
                                                context,
                                                widget.userModel,
                                              );
                                            },
                                          ),
                                      child: SvgPicture.asset(
                                        cardData['heartSvgAssetPath'],
                                        height: width * 0.10,
                                        width: width * 0.10,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        onCardTap: () => HomeCardPopups().showCardPopup(
                          context,
                          index,
                          cardData,
                          width,
                          height,
                          widget.userModel.soulUnlocked,
                          widget.userModel,
                        ),
                      );
                    }),
                  ),
                  UserActions(
                    width: width,
                    height: height,
                    swipeController:
                        widget.swipeController ?? SwipableStackController(),
                  ),
                  SizedBox(height: height * 0.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _buildLockedOverlay(double width, double height) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.lock,
            color: AppColors.accentWhite,
            size: width * 0.1,
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Match with this person to view",
            style: TextStyle(
              color: AppColors.accentWhite,
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
