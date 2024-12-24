import 'package:flutter/material.dart';
import '../app_export.dart';

extension on TextStyle {
  TextStyle get racingSansOne {
    return copyWith(
      fontFamily: 'Racing Sans One',
    );
  }

  TextStyle get lexend {
    return copyWith(
      fontFamily: 'Lexend',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get lobster {
    return copyWith(
      fontFamily: 'Lobster',
    );
  }
}

/// A colletion of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily specifi font families to text.

class CustomTextStyles {
  // Body text style

  // Title text style
  static TextStyle get titleLargeRobotoOnErrorContainer =>
      theme.textTheme.titleLarge!.roboto.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w500,
      );
}
