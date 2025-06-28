import 'package:flutter/material.dart';
import 'package:potential/features/home/helpers/home_page_helper.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/widgets/custom_snackbar.dart';
import 'package:swipable_stack/swipable_stack.dart';

class UserActions extends StatelessWidget {
  final SwipableStackController swipeController;
  UserActions({
    super.key,
    required this.width,
    required this.height,
    required this.swipeController,
  });

  final double width;
  final double height;

  final HomePageHelper homePageHelper = HomePageHelper();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: width * 0.15,
            height: width * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 238, 143, 143),
                  AppColors.accentRed,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () =>
                  swipeController.next(swipeDirection: SwipeDirection.left),
              icon: Icon(Icons.close, color: AppColors.accentWhite),
            ),
          ),
          Container(
            width: width * 0.15,
            height: width * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 238, 143, 143),
                  AppColors.accentRed,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => CustomSnackBarHelper.showCustomSnackbar(
                context,
                "Reserve Feature Coming Soon!",
              ),
              icon: Icon(
                Icons.lock_clock_outlined,
                color: AppColors.accentWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
