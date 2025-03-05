import 'package:flutter/cupertino.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppSizes {
  static final AppSizes _instance = AppSizes._internal();
  AppSizes._internal();
  factory AppSizes() => _instance;

  // -------------- Font Size -------------------- //
  static double headingSize = 18.sp;
  static double titleSize = 16.sp;
  static double subtitleSize = 14.5.sp;
  static double smallSubtitleSize = 14.sp;

  // ---- custom fonts ----
  static double f10 = 10.sp;
  static double f12 = 12.sp;
  static double f14 = 14.sp;
  static double f16 = 16.sp;
  static double f18 = 18.sp;

  // -------------- Font Weight -------------------- //
  static const FontWeight w400 = FontWeight.w400;
  static const FontWeight w500 = FontWeight.w500;
  static const FontWeight w600 = FontWeight.w600;
  static const FontWeight wBold = FontWeight.bold;

  // --------------- Padding Size ------------------ //
  static EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 1.5.h,
    vertical: 1.7.h,
  );
  static EdgeInsets defaultPadding = EdgeInsets.all(s14);
  static EdgeInsets withOutBottomPadding = EdgeInsets.only(
    top: AppSizes.smallHeight,
    left: AppSizes.mediumWidth,
    right: AppSizes.mediumWidth,
  );
  static EdgeInsets moreBottomPadding = EdgeInsets.only(
    top: AppSizes.smallHeight,
    left: AppSizes.smallWidth,
    right: AppSizes.smallWidth,
    bottom: mediumHeight + s6,
  );
  static EdgeInsets smallTopPadding = EdgeInsets.only(
    top: AppSizes.smallHeight,
    left: AppSizes.mediumWidth,
    right: AppSizes.mediumWidth,
    bottom: AppSizes.mediumHeight,
  );

  // -------------- Icon Size -------------------- //
  static double iconSize = 17.sp;
  static double bigIconSize = 19.sp;
  static double vBigIconSize = 21.sp;

  // -------------- Border Radius -------------------- //
  static BorderRadius defaultBorderRadius = BorderRadius.circular(s12);

  // -------------- Space size -------------------- //
  static double smallHeight = 1.h;
  static double smallWidth = 1.w;
  static double mediumHeight = 2.7.h;
  static double mediumWidth = 2.7.w;
  static double bigHeight = 3.h;
  static double bigWidth = 3.w;

  // --------------- Random Size -------------------- //
  static double s4 = 4.sp;
  static double s6 = 6.sp;
  static double s8 = 8.sp;
  static double s10 = 10.sp;
  static double s12 = 12.sp;
  static double s14 = 14.sp;
  static double s16 = 16.sp;
  static double s18 = 18.sp;
  static double s20 = 20.sp;
  static double s22 = 22.sp;
}
