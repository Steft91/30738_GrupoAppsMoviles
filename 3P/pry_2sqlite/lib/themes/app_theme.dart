import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryDark,
      surface: AppColors.lightSurface,
      onPrimary: AppColors.white,
      onSecondary: AppColors.lightText,
      onSurface: AppColors.lightText,
      error: AppColors.error,
    ),
    fontFamily: 'Roboto',

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.lightText,
      centerTitle: false,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 0,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurfaceAlt,
      labelStyle: const TextStyle(color: AppColors.lightTextMuted),
      hintStyle: const TextStyle(color: AppColors.lightTextMuted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.lightBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.lightBorder),
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.lightBorder,
      thickness: 1,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightTextMuted,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lightSurface,
      contentTextStyle: const TextStyle(color: AppColors.lightText),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      behavior: SnackBarBehavior.floating,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.lightTextMuted),
      bodyLarge: TextStyle(color: AppColors.lightText),
      titleLarge: TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
      ),
      titleMedium: TextStyle(
        color: AppColors.lightText,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primaryDark,
      surface: AppColors.darkSurface,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.darkText,
      error: AppColors.error,
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.darkText,
      centerTitle: false,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceAlt,
      labelStyle: const TextStyle(color: AppColors.darkTextMuted),
      hintStyle: const TextStyle(color: AppColors.darkTextMuted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkBorder,
      thickness: 1,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.darkTextMuted,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkSurfaceAlt,
      contentTextStyle: const TextStyle(color: AppColors.darkText),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      behavior: SnackBarBehavior.floating,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.darkTextMuted),
      bodyLarge: TextStyle(color: AppColors.darkText),
      titleLarge: TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
      ),
      titleMedium: TextStyle(
        color: AppColors.darkText,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
