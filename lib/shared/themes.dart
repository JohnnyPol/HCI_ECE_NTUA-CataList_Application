import 'package:flutter/material.dart';

// Define the app's color palette
class AppColors {
  static const startBGcolor = Color(0xFFA2A5D4);
  static const calmBlueDarker = Color(0xFF63A9CC);
  static const textPrimary = Color(0xFF0A1172);
  static const lightBlueColor = Color(0xFF82EEFD);
}

// Define the app's text styles
class AppTextStyles {
  static const displayMedium = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 45,
    fontFamily: 'Lobster',
    fontWeight: FontWeight.w400,
    height: 1,
    letterSpacing: 0.50,
  );

  static const buttonText = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
  );
}

// Define reusable decorations
class AppDecoration {
  static const calmbluedarker = BoxDecoration(
    color: AppColors.calmBlueDarker,
  );
}

// Define reusable border radius styles
class BorderRadiusStyle {
  static const roundedBorder40 = BorderRadius.all(Radius.circular(40));
}

// Combine everything in a theme for convenience
final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.startBGcolor,
  textTheme: TextTheme(
    displayMedium: AppTextStyles.displayMedium,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.calmBlueDarker,
  ),
);
