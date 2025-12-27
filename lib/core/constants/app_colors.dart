import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors (Blue theme)
  static const Color primary = Color(0xFF2196F3); // Blue
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);
  
  // Background Colors (Dark theme)
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color surfaceLight = Color(0xFF2C2C2C);
  
  // Background Gradient (from HTML: linear-gradient(to bottom, #2c2c2c -42.11%, #040404 119.47%))
  // Flexible gradient that fills full screen - subtle transition from dark gray to black
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 49, 49, 49), // #2c2c2c - Dark gray at top
      Color.fromARGB(255, 31, 31, 31), // #040404 - Pure black at bottom
    ],
    stops: [0.0, 1.0], // Full screen coverage
    tileMode: TileMode.clamp, // Ensures gradient fills entire area
  );

  // Improved background gradient with better color transition
  static const LinearGradient improvedBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 50, 50, 50), // Slightly lighter top
      Color.fromARGB(255, 44, 44, 44), // #2c2c2c
      Color(0xFF040404), // #040404 - Darker bottom
    ],
    stops: [0.0, 0.5, 1.0],
  );
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);
  
  // Accent Colors
  static const Color accent = Color(0xFF2196F3);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Status Colors
  static const Color connected = Color(0xFF4CAF50);
  static const Color disconnected = Color(0xFFF44336);
  static const Color connecting = Color(0xFFFF9800);
  
  // Car Status Colors
  static const Color parked = Color(0xFF808080);
  static const Color running = Color(0xFF4CAF50);
  static const Color warningStatus = Color(0xFFFF9800);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );
  
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
  );
}

