import 'package:flutter/material.dart';
import 'package:potential/app/theme.dart';

extension AppColorExtension on BuildContext {
  AppTheme get colors => Theme.of(this).extension<AppTheme>()!;
}
