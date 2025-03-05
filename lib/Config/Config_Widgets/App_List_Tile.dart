import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../App_Configs/App_Colors.dart';
import '../App_Configs/App_Sizes.dart';
import 'Shadowed_Container.dart';
import 'Text_Widget.dart';

class AppListTile extends StatelessWidget {
  final Widget? prefixWidget;
  final VoidCallback onTap;
  final IconData? prefixIcon;
  final String title;
  final String? subTitle;
  final bool? isArrowRight;
  final Color? backgroundColor, shadowColor, titleColor, subtitleColor;
  final List<Color>? backgroundGradient;
  final double? prefixIconSize,
      listTilePadding,
      titleSize,
      subtitleSize,
      prefixPadding;
  final int? maxLines;

  const AppListTile({
    super.key,
    this.prefixIcon = Icons.ac_unit_rounded,
    required this.title,
    this.backgroundColor,
    this.subTitle,
    this.backgroundGradient,
    this.isArrowRight,
    this.prefixIconSize,
    this.listTilePadding,
    this.maxLines,
    this.titleSize,
    this.subtitleSize,
    required this.onTap,
    this.shadowColor,
    this.prefixWidget,
    this.prefixPadding,
    this.titleColor,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      isBorder: false,
      shadowColor: shadowColor,
      shadowBlur: 3,
      backgroundColor: backgroundColor,
      padding: EdgeInsets.all(listTilePadding ?? 12.sp),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(prefixPadding ?? 10.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
            ),
            child: prefixWidget ??
                Icon(
                  prefixIcon,
                  size: prefixIconSize ?? AppSizes.iconSize + 7,
                  color: AppColors.whiteColor,
                ),
          ),
          SizedBox(width: AppSizes.mediumWidth),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TText(
                  text: title,
                  maxLine: maxLines ?? 2,
                  fontWeight: FontWeight.bold,
                  fontColor: titleColor,
                  fontSize: titleSize ?? AppSizes.titleSize,
                ),
                if (subTitle != null) SizedBox(height: .5.h),
                if (subTitle != null)
                  TText(
                    text: subTitle!,
                    maxLine: 3,
                    fontColor: subtitleColor,
                    fontSize: subtitleSize ?? AppSizes.titleSize - 1.5,
                  )
              ],
            ),
          ),
          if (isArrowRight != null)
            Icon(
              Icons.arrow_forward_ios,
              size: AppSizes.iconSize,
            )
        ],
      ),
    );
  }
}
