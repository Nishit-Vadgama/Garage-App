import 'package:flutter/material.dart';

import 'App_Colors.dart';
import 'App_Sizes.dart';

class AppTextStyles {
  static TextStyle headingTextStyle = TextStyle(
    fontSize: AppSizes.headingSize,
    color: AppColors.blackColor,
    fontWeight: AppSizes.w500,
    fontFamily: "poppins",
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle normalTextStyle = TextStyle(
    fontSize: AppSizes.titleSize,
    color: AppColors.blackColor,
    fontWeight: AppSizes.w400,
    fontFamily: "poppins",
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle boldTextStyle = TextStyle(
    fontSize: AppSizes.titleSize,
    color: AppColors.blackColor,
    fontWeight: AppSizes.wBold,
    fontFamily: "poppins",
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle subTitleTextStyle = TextStyle(
    fontSize: AppSizes.subtitleSize,
    color: AppColors.blackColor,
    fontFamily: "poppins",
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle greyTextStyle = TextStyle(
    fontSize: AppSizes.titleSize,
    color: AppColors.textGrey,
    fontWeight: AppSizes.w400,
    fontFamily: "poppins",
    overflow: TextOverflow.ellipsis,
  );
}
