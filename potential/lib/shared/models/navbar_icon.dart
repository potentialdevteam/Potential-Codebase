import 'package:flutter/material.dart';

class NavIconData {
  final String name;
  final IconData icon;
  final bool isSelected;
  void Function()? onTap;

  NavIconData({
    required this.name,
    required this.icon,
    required this.isSelected,
    this.onTap,
  });
}