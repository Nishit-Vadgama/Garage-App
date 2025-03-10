import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Config_Widgets/Text_Widget.dart';
import 'App_Colors.dart';
import 'App_Images.dart';
import 'App_Sizes.dart';

class Network_Controller extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    Check_Connectivity();
    super.onInit();
  }

  Check_Connectivity() =>
      _connectivity.onConnectivityChanged.listen(_check_Connection);

  _check_Connection(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.dialog(
        useSafeArea: false,
        Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: double.infinity,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: AppSizes.defaultBorderRadius,
              color: AppColors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  AppImages.No_Internet_Animation,
                  fit: BoxFit.cover,
                  height: 25.h,
                ),
                TText(
                  text: "No Internet Connection",
                  fontColor: AppColors.red,
                  fontSize: AppSizes.headingSize,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: AppSizes.smallHeight),
                TText(
                  text: "Please check your internet connection and try again.",
                  fontColor: AppColors.text,
                  maxLine: 2,
                  fontCentered: true,
                  fontSize: AppSizes.titleSize,
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
        barrierColor: AppColors.white,
      );
    } else {
      if (!connectivityResult.contains(ConnectivityResult.none)) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
      }
    }
  }
}
