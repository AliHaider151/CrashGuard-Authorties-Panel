import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF447DFF);
  static const Color purple = Color(0xFF9E5DF0);
  static const Color yellow = Color(0xFFEAB308);
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static Color darkGrey = Colors.black87.withOpacity(.7);
  static Color textBlack = Colors.black;
  static Color textWhite = Colors.white;
  static Color tabbarColor = Color(0xffF1F5F9);
  static Color iconRed = Colors.red;
  static Color grey = Colors.grey;
  static Color green = Colors.green;

  static const Color iconBlack = Colors.black;
  static List<Color> gradientStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return [Colors.green, Colors.lightGreen];
      case "inactive":
        return [Colors.red, Colors.redAccent];
      case "waitlist":
        return [Colors.yellow, Colors.yellowAccent];
      default:
        return [Colors.grey, Colors.black26];
    }
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scened':
        return AppColors.primary;
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.red;

      default:
        return Colors.green;
    }
  }
}
