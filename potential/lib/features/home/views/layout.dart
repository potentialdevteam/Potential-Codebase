import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:potential/features/home/widgets/appreciation.dart';
import 'package:potential/features/home/widgets/four_cards.dart';
import 'package:potential/features/home/widgets/reserve_profile.dart';
import 'package:potential/features/home/widgets/unlock_soul.dart';
import 'package:potential/features/home/widgets/your_potential.dart';
import 'package:potential/shared/widgets/navbar.dart';
import 'package:potential/features/profile/views/profile.dart';
import 'package:potential/features/arena/views/arena.dart';
import 'package:potential/features/chat/views/chat.dart';
import 'package:potential/features/home/views/home.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentPageIndex = 0;
  bool _checkedDialog = false;
  final List<Widget> pages = [];
  final PageController _pageController = PageController();

  @override
  void initState() {
    pages.addAll([
      HomePage(showInfoDialogCallback: _showInformationDialog),
      const ArenaPage(),
      const ChatPage(),
      const AccountPage(),
    ]);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAndShowDialog();
  }

  Future<void> _checkAndShowDialog() async {
    if (_checkedDialog) return;

    _checkedDialog = true;
    final prefs = await SharedPreferences.getInstance();
    final hasSeenDialog = prefs.getBool('hasSeenInfoDialog') ?? false;

    if (!hasSeenDialog) {
      await _showInformationDialog();

      await prefs.setBool('hasSeenInfoDialog', true);
    }
  }

  Future<void> _showInformationDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.65,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.bgBlack.withAlpha(50),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.accentRed),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        pageSnapping: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          GuideFourCards(),
                          GuideUnlockSoul(),
                          GuideAppreciation(),
                          GuideYourPotential(),
                          GuideReserveProfile(),
                        ],
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 5,
                      effect: WormEffect(
                        // You can try JumpingDotEffect, ExpandingDotsEffect, etc.
                        dotColor: Colors.grey,
                        activeDotColor:
                            Colors.red, // Use AppColors.accentRed if you like
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // color: AppColors.accentRed,
                          gradient: LinearGradient(
                            colors: <Color>[
                              AppColors.accentRed,
                              AppColors.accentWhite,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: Stack(
        children: <Widget>[
          IndexedStack(index: currentPageIndex, children: pages),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: 0,
            right: 0,
            child: Center(
              child: CustomNavbar(
                currentPageIndex: currentPageIndex,
                onItemSelected: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
