import 'package:flutter/material.dart';
import 'package:potential/core/constants/colors.dart';

class NavIcon extends StatefulWidget {
  final String? name;
  final IconData? icon;
  final bool? isSelected;
  final Function? onTap;
  const NavIcon({super.key, this.name, this.icon, this.isSelected, this.onTap});

  @override
  State<NavIcon> createState() => _NavIconState();
}

class _NavIconState extends State<NavIcon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: widget.isSelected! ? Colors.red : Colors.transparent,
              gradient: LinearGradient(
                colors: [AppColors.accentRed, AppColors.accentWhite],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                icon: Icon(
                  widget.icon,
                  color: widget.isSelected! ? Colors.white : Colors.grey,
                ),
                onPressed: () {
                  if (widget.onTap != null) {
                    widget.onTap!();
                  }
                },
              ),
            ),
          ),
          if (widget.name != null)
            Text(
              widget.name!,
              style: TextStyle(
                color: widget.isSelected! ? Colors.white : Colors.grey,
                fontSize: 12,
                fontWeight: widget.isSelected!
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }
}
