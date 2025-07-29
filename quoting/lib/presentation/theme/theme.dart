import 'package:flutter/material.dart';
import 'package:quoting/presentation/theme/pallete.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppPallete.primary,
  scaffoldBackgroundColor: AppPallete.lightBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppPallete.primary,
    foregroundColor: AppPallete.lightText,
  ),
  colorScheme: ColorScheme.light(
    primary: AppPallete.primary,
    secondary: AppPallete.secondary,
    surface: AppPallete.lightSurface,
    onPrimary: AppPallete.lightText,
    onSecondary: AppPallete.accent,
    onSurface: AppPallete.accent,
    error: AppPallete.errorColor,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppPallete.accent),
    bodyMedium: TextStyle(color: AppPallete.accent),
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
    onPrimary: AppPallete.secondary,
    onSecondary: AppPallete.primary,
    onSurface: AppPallete.secondary,
    error: AppPallete.errorColor,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppPallete.secondary),
    bodyMedium: TextStyle(color: AppPallete.secondary),
  ),
);
