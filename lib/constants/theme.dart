import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(primary: AppColors.primary),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
    ),
    fontFamily: "Poppins",
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        color: AppColors.textBlack,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.textBlack,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        color: AppColors.textBlack,
        fontSize: 35,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(color: AppColors.textBlack, fontSize: 16),
      bodySmall: TextStyle(color: AppColors.textBlack, fontSize: 14),
    ),
  );

  // final ThemeData dark = ThemeData(
  //   brightness: Brightness.light,
  //   primaryColor: AppColors.primary,
  //   colorScheme: ColorScheme.dark(primary: AppColors.primary),
  //   scaffoldBackgroundColor: AppColors.backgroundLight,
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: AppColors.primary,
  //     elevation: 0,
  //   ),
  //   fontFamily: "Poppins",
  //   textTheme: TextTheme(
  //     headlineSmall: TextStyle(
  //       color: AppColors.textWhite,
  //       fontSize: 32,
  //       fontWeight: FontWeight.bold,
  //     ),
  //     headlineMedium: TextStyle(
  //       color: AppColors.textWhite,
  //       fontSize: 20,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     bodySmall: TextStyle(
  //       color: AppColors.textWhite,
  //       fontSize: 16,
  //     ),
  //     bodyMedium: TextStyle(
  //       color: AppColors.textWhite,
  //       fontSize: 14,
  //     ),
  //   ),
  // );
}
