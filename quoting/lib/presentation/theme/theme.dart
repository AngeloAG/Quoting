import 'package:flutter/material.dart';
import 'package:quoting/presentation/theme/pallete.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppPallete.primary,
  scaffoldBackgroundColor: AppPallete
      .lightBackground, // Should be a soft off-white, e.g. Color(0xFFF5F5F5)
  appBarTheme: AppBarTheme(
    backgroundColor: AppPallete.primary,
    foregroundColor: Colors.white, // High contrast for app bar text
    elevation: 1,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.light(
    primary: AppPallete.primary,
    secondary: AppPallete.secondary,
    surface: Colors.white, // Neutral surface for cards/dialogs
    background: AppPallete.lightBackground,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black87, // Use dark text for surfaces
    error: AppPallete.errorColor,
    onError: Colors.white,
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    shadowColor: Colors.black12,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black87,
    ), // Use dark neutral for body text
    bodyMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    labelLarge: TextStyle(color: AppPallete.primary),
  ),
  dividerColor: Colors.black12,
  iconTheme: IconThemeData(color: AppPallete.primary),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Colors.black12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppPallete.primary),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppPallete.primary,
  scaffoldBackgroundColor: AppPallete.darkBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppPallete.accent,
    foregroundColor: AppPallete.darkText,
  ),
  colorScheme: ColorScheme.dark(
    primary: AppPallete.primary,
    secondary: AppPallete.secondary,
    surface: AppPallete.darkSurface,
    onPrimary: AppPallete.darkText,
    onSecondary: AppPallete.primary,
    onSurface: AppPallete.secondary,
    error: AppPallete.errorColor,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppPallete.darkText),
    bodyMedium: TextStyle(color: AppPallete.darkText),
  ),
);
