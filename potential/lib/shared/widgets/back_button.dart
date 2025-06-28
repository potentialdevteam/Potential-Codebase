import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, this.addPadding = true, this.onPressed});
  final bool addPadding;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: addPadding ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
      child: Container(
        width: width * 0.14,
        height: width * 0.14,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.accentRed, width: 2),
        ),
        child: IconButton(
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            } else {
              Navigator.pop(context);
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.accentWhite,
          ),
          iconSize: 17,
        ),
      ),
    );
  }
}
