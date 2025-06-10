import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  late final Size screenSize;

  Responsive(this.context) {
    screenSize = MediaQuery.of(context).size;
  }

  /// Get full screen width
  double get width => screenSize.width;

  /// Get full screen height
  double get height => screenSize.height;

  /// Get width percentage
  double wp(double percentage) => screenSize.width * (percentage / 100);

  /// Get height percentage
  double hp(double percentage) => screenSize.height * (percentage / 100);

  /// Scalable font size based on screen size
  double sp(double scaleFactor) =>
      (screenSize.width + screenSize.height) / 2 * (scaleFactor / 100);

  /// Device type helpers
  bool get isMobile => screenSize.width < 600;
  bool get isTablet => screenSize.width >= 600 && screenSize.width < 1024;
  bool get isDesktop => screenSize.width >= 1024;
}
