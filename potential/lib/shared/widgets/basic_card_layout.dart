import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potential/core/constants/colors.dart';
import 'package:potential/shared/models/basic_card.dart';

class BasicCardLayout extends StatefulWidget {
  const BasicCardLayout({
    super.key,
    required this.cardModel,
    required this.isSoulCardUnlocked,
    required this.isSoulCard,
    required this.overlayWidget,
    required this.onCardTap,
  });
  final BasicCardModel cardModel;
  final bool isSoulCardUnlocked;
  final bool isSoulCard;
  final Widget overlayWidget;
  final Function() onCardTap;

  @override
  State<BasicCardLayout> createState() => _BasicCardLayoutState();
}

class _BasicCardLayoutState extends State<BasicCardLayout> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onCardTap,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          shadowColor: Colors.blueGrey,
          child: Container(
            width: width * 0.85,
            height: height * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    widget.isSoulCardUnlocked == false &&
                        widget.isSoulCard == true
                    ? [Colors.grey[800]!, Colors.grey[700]!]
                    : widget.cardModel.cardGradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: widget.isSoulCardUnlocked || !widget.isSoulCard,
                  child: Positioned(
                    right: 10,
                    child: SvgPicture.asset(
                      widget.cardModel.cardAssetPath,
                      height: widget.isSoulCard ? height * 0.1 : height * 0.15,
                      width: widget.isSoulCard ? height * 0.1 : height * 0.15,
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cardModel.cardTitle,
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.cardModel.cardDescription,
                        style: TextStyle(
                          color: AppColors.accentWhite,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.overlayWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
