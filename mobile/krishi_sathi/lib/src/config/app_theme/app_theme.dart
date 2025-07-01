import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme({required bool isDark}) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.black,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.black,
      ),
    );
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: AppColors.black,
      primaryColorDark: AppColors.black,
      shadowColor: AppColors.steel,
      brightness: isDark ? Brightness.dark : Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.steel,
      ),
      textTheme: TextTheme(
        bodySmall: AppTextStyles.lightStyle(color: AppColors.black),
        bodyMedium: AppTextStyles.regularStyle(color: AppColors.black),
        bodyLarge: AppTextStyles.semiBoldStyle(color: AppColors.white),
        titleMedium: AppTextStyles.mediumStyle(color: AppColors.black),
        titleLarge: AppTextStyles.boldStyle(color: AppColors.black),
        headlineMedium: AppTextStyles.blackStyle(color: AppColors.black),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        fillColor: AppColors.blackWith40Opacity,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: AppColors.white,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        labelStyle: AppTextStyles.regularStyle(color: AppColors.steel),
      ),
    );
  }
}
