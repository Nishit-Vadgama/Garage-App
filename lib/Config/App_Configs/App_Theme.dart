import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'App_Colors.dart';
import 'App_Sizes.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'montserrat',
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.grey,
    appBarTheme: AppBarTheme(
      toolbarHeight: 8.h,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      iconTheme: IconThemeData(
        color: AppColors.white,
        size: AppSizes.iconSize + 4,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
  );
}
