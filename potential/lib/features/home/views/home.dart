import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potential/core/configs/theme_extention.dart';
import 'package:potential/features/home/controllers/home_controller.dart';
import 'package:potential/features/home/helpers/no_swiper_wrapper.dart';
import 'package:potential/features/home/widgets/user.dart';
import 'package:potential/features/home/helpers/home_page_helper.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomePage extends StatefulWidget {
  final VoidCallback showInfoDialogCallback;
  const HomePage({super.key, required this.showInfoDialogCallback});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageHelper homePageHelper = HomePageHelper();
  final SwipableStackController swipeController = SwipableStackController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // app bar
            Container(
              width: width,
              height: height * 0.15,
              color: AppColors.bgBlack,
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/svg/app_logo.svg",
                    width: height * 0.05,
                    height: height * 0.05,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications, color: Colors.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: context.colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: widget.showInfoDialogCallback,
                          icon: Icon(Icons.info_outlined, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // MAIN USER PROFILES + SWIPERS
            SizedBox(
              height: height * 0.85,
              width: width,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: height * 0.85,
                        color: Colors.transparent,
                        child: NoSwipeWrapper(
                          child: SwipableStack(
                            horizontalSwipeThreshold: 1,
                            allowVerticalSwipe: false,
                            controller: swipeController,
                            detectableSwipeDirections: {SwipeDirection.left},
                            overlayBuilder: (context, swipeProperty) {
                              if (swipeProperty.direction ==
                                  SwipeDirection.left) {
                                return Container(
                                  width: width,
                                  height: height * 0.85,
                                  color: Colors.transparent,
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: width * 0.4,
                                    height: height * 0.1,
                                    padding: EdgeInsets.all(width * 0.03),
                                    decoration: BoxDecoration(
                                      color: AppColors.bgBlack.withAlpha(150),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppColors.accentRed,
                                        width: 5,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "REJECT",
                                        style: TextStyle(
                                          color: AppColors.accentRed,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Text("Right Swipe Detected");
                              }
                            },
                            itemCount: 10,
                            builder: (context, properties) {
                              final idx =
                                  properties.index %
                                  HomeController().getUserProfiles().length;
                              return Center(
                                child: SizedBox(
                                  width: width,
                                  height: height,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: UserProfile(
                                      userModel: HomeController()
                                          .getUserProfiles()[idx],
                                      swipeController: swipeController,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
