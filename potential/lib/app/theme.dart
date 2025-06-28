import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color background;
  final Color grey;
  final Color secondaryRed;
  final Color secondaryWhite;
  final Color sparkPurple;
  final Color mindBlue;
  final Color heartOrange;
  final Color soulYellow;
  final Color onBackground;

  const AppTheme({
    required this.background,
    required this.grey,
    required this.secondaryRed,
    required this.secondaryWhite,
    required this.sparkPurple,
    required this.mindBlue,
    required this.heartOrange,
    required this.soulYellow,
    required this.onBackground,
  });

  @override
  AppTheme copyWith({
    Color? background,
    Color? grey,
    Color? secondaryRed,
    Color? secondaryWhite,
    Color? sparkPurple,
    Color? mindBlue,
    Color? heartOrange,
    Color? soulYellow,
    Color? onBackground,
  }) {
    return AppTheme(
      background: background ?? this.background,
      grey: grey ?? this.grey,
      secondaryRed: secondaryRed ?? this.secondaryRed,
      secondaryWhite: secondaryWhite ?? this.secondaryWhite,
      sparkPurple: sparkPurple ?? this.sparkPurple,
      mindBlue: mindBlue ?? this.mindBlue,
      heartOrange: heartOrange ?? this.heartOrange,
      soulYellow: soulYellow ?? this.soulYellow,
      onBackground: onBackground ?? this.onBackground,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(
    covariant ThemeExtension<AppTheme>? other,
    double t,
  ) {
    if (other is! AppTheme) return this;
    return AppTheme(
      background: Color.lerp(background, other.background, t) ?? background,
      grey: Color.lerp(grey, other.grey, t) ?? grey,
      secondaryRed:
          Color.lerp(secondaryRed, other.secondaryRed, t) ?? secondaryRed,
      secondaryWhite:
          Color.lerp(secondaryWhite, other.secondaryWhite, t) ?? secondaryWhite,
      sparkPurple: Color.lerp(sparkPurple, other.sparkPurple, t) ?? sparkPurple,
      mindBlue: Color.lerp(mindBlue, other.mindBlue, t) ?? mindBlue,
      heartOrange: Color.lerp(heartOrange, other.heartOrange, t) ?? heartOrange,
      soulYellow: Color.lerp(soulYellow, other.soulYellow, t) ?? soulYellow,
      onBackground:
          Color.lerp(onBackground, other.onBackground, t) ?? onBackground,
    );
  }
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(),
  extensions: const <ThemeExtension<AppTheme>>[
    AppTheme(
      background: Color.fromARGB(255, 255, 255, 255),
      onBackground: Colors.black,
      grey: Color.fromARGB(255, 92, 92, 92),
      secondaryRed: Color(0xFFC1121F),
      secondaryWhite: Color(0xFFFAFAFA),
      sparkPurple: Color(0xFFC623F6),
      mindBlue: Color(0xFF0703FF),
      heartOrange: Color(0xFFFF5325),
      soulYellow: Color(0xFFFFD900),
    ),
  ],
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontFamily: 'Vastago Grotesk'),
    bodySmall: TextStyle(fontFamily: 'Vastago Grotesk'),
    bodyLarge: TextStyle(fontFamily: 'Vastago Grotesk'),
    headlineMedium: TextStyle(
      fontFamily: 'Vastago Grotesk',
      fontSize: 20,
      color: Colors.black,
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(),
  extensions: const <ThemeExtension<AppTheme>>[
    AppTheme(
      background: Color(0xFF040404),
      onBackground: Color(0xFFFAFAFA),
      grey: Color.fromARGB(255, 40, 40, 40),
      secondaryRed: Color(0xFFC1121F),
      secondaryWhite: Color(0xFFFAFAFA),
      sparkPurple: Color(0xFFC623F6),
      mindBlue: Color(0xFF0703FF),
      heartOrange: Color(0xFFFF5325),
      soulYellow: Color(0xFFFFD900),
    ),
  ],
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontFamily: 'Vastago Grotesk'),
    bodySmall: TextStyle(fontFamily: 'Vastago Grotesk'),
    bodyLarge: TextStyle(fontFamily: 'Vastago Grotesk'),
    headlineMedium: TextStyle(
      fontFamily: 'Vastago Grotesk',
      fontSize: 20,
      color: Colors.white,
    ),
  ),
);
