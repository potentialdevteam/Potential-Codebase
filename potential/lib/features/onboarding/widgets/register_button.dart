import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:potential/core/constants/colors.dart';

class RegisterButton extends StatefulWidget {
  final void Function()? onTap;
  final Icon? icon;
  final SvgPicture? svgIcon;
  const RegisterButton({
    required this.onTap,
    this.icon,
    this.svgIcon,
    super.key,
  });

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: screenWidth * 0.24,
        height: screenWidth * 0.15,
        decoration: BoxDecoration(
          border: BoxBorder.all(color: AppColors.accentRed, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: widget.svgIcon ?? widget.icon),
      ),
    );
  }
}
