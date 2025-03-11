import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();
  AppColors._internal();
  factory AppColors() => _instance;

  static Color primary = Color(0XFF043161);
  static Color pastel = Color(0XFFE8F3FF);
  static Color shadow = Color(0XFFD2D2D2);
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color grey = Colors.grey.shade200;
  static Color text = Color(0XFF7E7E7E);
  static Color red = Colors.red;
  static Color green = Colors.green;
  static Color redPastle = Color(0XFFFED0D2);
  static Color greenPastle = Color(0XFFDCF6BE);
}

Color NvColor(String color) {
  switch (color) {
    case "primary":
      return AppColors.primary;

    case "black":
      return AppColors.black;

    case "grey":
      return AppColors.grey;

    case "red":
      return AppColors.red;

    case "white":
      return AppColors.white;

    case "pastle":
      return AppColors.pastel;

    case "shadow":
      return AppColors.shadow;

    case "green":
      return AppColors.green;

    case "text":
      return AppColors.text;

    default:
      return AppColors.white;
  }
}
