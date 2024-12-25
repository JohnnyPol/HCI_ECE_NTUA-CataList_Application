import 'package:flutter/material.dart';
import '../app_export.dart';

class AppDecoration {
  // Add decorations
  static BoxDecoration get calmbluedarker => BoxDecoration(
        color: appTheme.teal300,
      );
  static BoxDecoration get linearBGcolors => BoxDecoration(
        gradient: LinearGradient(
          colors: [
            appTheme.homeBGcolor1, // Top color
            appTheme.homeBGcolor2, // Bottom color
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
}

class BorderRadiusStyle {
  static BorderRadius get roundedBorder40 => BorderRadius.circular(40.h);
}
