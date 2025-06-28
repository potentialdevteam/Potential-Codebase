import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class InterestOption extends StatefulWidget {
  final String unicode;
  final String title;
  final bool isSelected;
  final Function? onTap;
  const InterestOption({
    this.onTap,
    required this.isSelected,
    required this.unicode,
    required this.title,
    super.key,
  });

  @override
  State<InterestOption> createState() => _InterestOptionState();
}

class _InterestOptionState extends State<InterestOption> {
  String get emoji {
    final codePoint = int.parse(widget.unicode, radix: 16);
    return String.fromCharCode(codePoint);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap as void Function()?,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isSelected
              ? AppColors.accentRed
              : AppColors.accentWhite,
        ),
        child: Text(
          "$emoji ${widget.title}",
          style: TextStyle(
            color: widget.isSelected
                ? AppColors.accentWhite
                : AppColors.bgBlack,
          ),
        ),
      ),
    );
  }
}
