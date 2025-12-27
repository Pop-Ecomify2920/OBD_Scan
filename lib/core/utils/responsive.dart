import 'package:flutter/material.dart';

class Responsive {
  // Base design dimensions (assuming design was made for a standard phone)
  static const double _baseWidth = 390.0;
  static const double _baseHeight = 844.0;

  // Get responsive width multiplier
  static double widthMultiplier(BuildContext context) {
    return MediaQuery.of(context).size.width / _baseWidth;
  }

  // Get responsive height multiplier
  static double heightMultiplier(BuildContext context) {
    return MediaQuery.of(context).size.height / _baseHeight;
  }

  // Get responsive font size
  static double fontSize(BuildContext context, double baseSize) {
    final multiplier = widthMultiplier(context);
    // Clamp multiplier to prevent too small/large text
    // For very small screens, ensure minimum readability
    final clampedMultiplier = multiplier.clamp(0.75, 1.3);
    return baseSize * clampedMultiplier;
  }

  // Get responsive padding
  static EdgeInsets padding(BuildContext context, {
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    final wMultiplier = widthMultiplier(context);
    final hMultiplier = heightMultiplier(context);
    
    return EdgeInsets.only(
      top: (top ?? vertical ?? all ?? 0) * hMultiplier,
      bottom: (bottom ?? vertical ?? all ?? 0) * hMultiplier,
      left: (left ?? horizontal ?? all ?? 0) * wMultiplier,
      right: (right ?? horizontal ?? all ?? 0) * wMultiplier,
    );
  }

  // Get responsive size (for width/height)
  static double size(BuildContext context, double baseSize) {
    final multiplier = widthMultiplier(context);
    return baseSize * multiplier;
  }

  // Get responsive spacing
  static double spacing(BuildContext context, double baseSpacing) {
    final multiplier = widthMultiplier(context);
    // For very large spacing values, use height multiplier for better vertical scaling
    if (baseSpacing > 50) {
      final hMultiplier = heightMultiplier(context);
      return baseSpacing * hMultiplier.clamp(0.7, 1.3);
    }
    return baseSpacing * multiplier.clamp(0.7, 1.3);
  }

  // Check if device is small
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 360;
  }

  // Check if device is large
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }

  // Get screen width percentage
  static double widthPercent(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * (percent / 100);
  }

  // Get screen height percentage
  static double heightPercent(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * (percent / 100);
  }
}

