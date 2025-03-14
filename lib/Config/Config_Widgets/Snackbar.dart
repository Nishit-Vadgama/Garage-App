import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../App_Configs/App_Colors.dart';
import '../App_Configs/App_Sizes.dart';
import 'Text_Widget.dart';

App_Snackbar({required bool type, required String msg}) {
  Get.rawSnackbar(
    backgroundGradient: LinearGradient(
      colors: [
        AppColors.white,
        AppColors.white,
      ],
    ),
    messageText: TText(
      text: msg,
      fontSize: AppSizes.titleSize,
      fontWeight: AppSizes.wBold,
      maxLine: 2,
      fontColor: type ? AppColors.black : AppColors.red,
    ),
    borderRadius: AppSizes.s18,
    snackPosition: SnackPosition.BOTTOM,
    snackStyle: SnackStyle.FLOATING,
    shouldIconPulse: false,
    duration: const Duration(seconds: 2),
    barBlur: 10,
    icon: Icon(
      type ? Icons.verified_outlined : Icons.error_outline,
      color: type ? AppColors.black : AppColors.red,
      size: AppSizes.bigIconSize,
    ),
    margin: EdgeInsets.all(AppSizes.s16),
    backgroundColor: AppColors.white,
  );
}
