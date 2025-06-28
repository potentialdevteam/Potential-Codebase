import 'dart:ui'; // For ImageFilter
import 'package:flutter/material.dart';
import 'package:potential/shared/widgets/nav_icon.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/models/navbar_icon.dart';

// ignore: must_be_immutable
class CustomNavbar extends StatefulWidget {
  int currentPageIndex;
  PageController? pageController;
  final Function(int) onItemSelected;
  CustomNavbar({
    super.key,
    required this.currentPageIndex,
    required this.onItemSelected,
    this.pageController,
  });

  @override
  State<CustomNavbar> createState() => _CustmoNavbarState();
}

class _CustmoNavbarState extends State<CustomNavbar> {
  late List<NavIconData> navIcons;

  List<NavIconData> getNavIcons() {
    return [
      NavIconData(name: 'Home', icon: Icons.home, isSelected: true),
      NavIconData(name: 'Arena', icon: Icons.shield_sharp, isSelected: false),
      NavIconData(name: 'Chat', icon: Icons.message_rounded, isSelected: false),
      NavIconData(
        name: 'Account',
        icon: Icons.account_circle,
        isSelected: false,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    navIcons = getNavIcons();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final navBarWidth = screenWidth * 0.95;
    final navBarHeight = screenHeight * 0.12;

    return Container(
      width: navBarWidth,
      height: navBarHeight,
      margin: EdgeInsets.only(bottom: screenHeight * 0.007),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.bgBlack.withAlpha(50),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: AppColors.accentRed),
            ),
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                final iconData = navIcons[index];
                return NavIcon(
                  icon: iconData.icon,
                  name: iconData.name,
                  isSelected: widget.currentPageIndex == index,
                  onTap: () => widget.onItemSelected(index),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
