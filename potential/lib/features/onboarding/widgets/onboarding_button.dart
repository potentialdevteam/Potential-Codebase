import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class OnboardingButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final Icon? icon;
  const OnboardingButton({
    required this.onPressed,
    required this.text,
    this.icon,
    super.key,
  });

  @override
  State<OnboardingButton> createState() => _OnboardingButtonState();
}

class _OnboardingButtonState extends State<OnboardingButton> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: screenWidth * 0.8,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentWhite.withAlpha(50),
              spreadRadius: 5,
              blurRadius: 30,
            ),
          ],
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 7,
            focalRadius: 10,
            colors: [AppColors.accentRed, AppColors.accentWhite],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.text,
                style: TextStyle(
                  color: AppColors.accentWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                  fontFamily: "Vastago Grotesk",
                ),
              ),
              SizedBox(width: 10),
              widget.icon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
