import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../App_Configs/App_Images.dart';
import '../App_Configs/App_Sizes.dart';
import 'Text_Widget.dart';

Widget No_Data() {
  return Column(
    spacing: AppSizes.smallHeight,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Lottie.asset(
        AppImages.No_Data_Animation,
        height: 18.h,
        fit: BoxFit.cover,
      ),
      TText(
        text: "No Data Found",
        fontWeight: AppSizes.wBold,
      ),
    ],
  );
}
