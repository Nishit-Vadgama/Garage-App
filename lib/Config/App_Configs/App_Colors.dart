import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();
  AppColors._internal();
  factory AppColors() => _instance;

  static const Color primaryColor = Color(0XFF043161);
  static const Color primaryPastelColor = Color(0XFFE8F3FF);
  static const Color shadowColor = Color(0XFFD2D2D2);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color blackGreyColor = Color(0XFF333333);
  static Color greyColor = Colors.grey.shade200;
  static const Color textGrey = Color(0XFF7E7E7E);
  static const Color redColor = Colors.red;
  static const Color successColor = Colors.greenAccent;
}
