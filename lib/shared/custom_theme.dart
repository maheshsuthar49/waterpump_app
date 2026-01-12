import 'package:flutter/material.dart';

class AppColors{

  static const Color primaryGreen = Color(0xff024a06);
  static const Color lightBackground = Color(0xffeafbea);
  static const Color accentColor = Color(0xff4c8750);
  static const Color errorColor = Color(0xFFC70039);
  static const Color cardBackground = Colors.white;
  static const Color secondaryText = Colors.grey;
}

class CustomAppTheme{
  static ThemeData get lightTheme{
    return ThemeData(
      primaryColor: AppColors.primaryGreen,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryGreen,
        secondary: AppColors.accentColor,
        surface: AppColors.cardBackground,
        error: AppColors.errorColor
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,

        textTheme: TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryGreen, fontSize: 24),
          headlineMedium: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryGreen, fontSize: 20),
          bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
    ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        )
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.primaryGreen),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2),
          ),
          labelStyle: const TextStyle(color: AppColors.primaryGreen),
        )
    );
  }
}