import 'package:flutter/material.dart';
import 'package:moniepoint_test/core/core.dart';

class AppTheme {
  const AppTheme();

  ThemeData get _mainTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        background: AppColors.backgroundColor,
        onBackground: Colors.white,
        secondary: AppColors.secondaryColor,
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'EuclidCircularA',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: 'EuclidCircularA',
          color: Color(0xFF232220),
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'EuclidCircularA',
          color: Color(0xFF232220),
        ),
        headlineSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'EuclidCircularA',
          color: Color(0xFF232220),
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'EuclidCircularA',
          color: Color(0xFF232220),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'EuclidCircularA',
          color: Color(0xFF232220),
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'EuclidCircularA',
          color: Color(0xFF232220),
        ),
        bodyMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'EuclidCircularA',
          color: Color(0xFF232220),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'EuclidCircularA',
          color: Color(0xFF232220),
        ),
      ),
    );
  }

  ThemeData get lightTheme => _mainTheme;

  ThemeData get darkTheme => _mainTheme.copyWith(
        brightness: Brightness.dark,
      );
}
