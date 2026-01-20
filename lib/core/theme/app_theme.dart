import 'package:flutter/material.dart';
import 'package:realstate/core/theme/app_palette.dart';

class AppTheme {
  // Common values
  static const double _borderRadius = 12;

  static const EdgeInsets _inputPadding = EdgeInsets.symmetric(
    vertical: 14,
    horizontal: 15,
  );
  static OutlineInputBorder _inputBorder({
    required Color color,
    double width = 1.5,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static final ThemeData themeMode = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.appBgColor,
    ),
    scaffoldBackgroundColor: AppPalette.appBgColor,


    inputDecorationTheme: InputDecorationTheme (
      filled: true,
      fillColor: AppPalette.textBoxColor,
      contentPadding: _inputPadding,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: BorderSide.none,
      ),

      enabledBorder: _inputBorder(color: AppPalette.inActiveColor),

      focusedBorder: _inputBorder(color: AppPalette.primary, width: 2.5),

      errorBorder: _inputBorder(color: AppPalette.red, width: 2),

      focusedErrorBorder: _inputBorder(color: AppPalette.red, width: 2.5),
    ),
  );
}
