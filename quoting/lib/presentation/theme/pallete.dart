import 'package:flutter/material.dart';

class AppPallete {
  // Main colors
  static const Color primary = Color(0xFFed7d4b);
  static const Color secondary = Color(0xFFd8d4d0);
  static const Color accent = Color(0xFF443f3c);

  // Light theme
  static const Color lightBackground = secondary;
  static const Color lightSurface = Colors.white;
  static const Color lightText = accent;

  // Dark theme
  static const Color darkBackground = accent;
  static const Color darkSurface = Color(0xFF2c2826);
  static const Color darkText = Colors.white;

  static const Color errorColor = Colors.redAccent;
  static const Color transparentColor = Colors.transparent;
}
