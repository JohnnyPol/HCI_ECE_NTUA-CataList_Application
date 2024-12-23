// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// These are the viewport values of your Figma design
const num FIGMA_DESIGN_WIDTH = 360;
const num FIGMA_DESIGN_HEIGHT = 800;

// Extension for making the UI responsive
extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get h => ((this * _width) / FIGMA_DESIGN_WIDTH);
  double get fSize => ((this * _width) / FIGMA_DESIGN_WIDTH);
}

// Utility class to calculate screen dimensions
class SizeUtils {
  static late double width;
  static late double height;
  static late double statusBarHeight;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
    statusBarHeight = mediaQuery.padding.top;
  }
}
