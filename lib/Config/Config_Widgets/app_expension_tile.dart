import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../App_Configs/App_Colors.dart';
import '../App_Configs/App_Sizes.dart';
import 'text_widget.dart';

class AppExpensionTile extends StatelessWidget {
  final List<Widget> children;
  final IconData? icon;
  final String title;
  final EdgeInsets? padding;
  final double? fontSize;
  final Color? collapsedBackgroundColor, backgroundColor;

  const AppExpensionTile({
    super.key,
    required this.children,
    this.icon,
    required this.title,
    this.padding,
    this.fontSize,
    this.collapsedBackgroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(AppSizes.s4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 6,
            blurStyle: BlurStyle.outer,
          )
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        iconColor: AppColors.primaryColor,
        collapsedBackgroundColor:
            collapsedBackgroundColor ?? Colors.transparent,
        backgroundColor: backgroundColor ?? Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: AppSizes.defaultBorderRadius),
        collapsedShape:
            RoundedRectangleBorder(borderRadius: AppSizes.defaultBorderRadius),
        expansionAnimationStyle: AnimationStyle(curve: Curves.ease),
        leading: icon != null
            ? Icon(
                icon,
                size: AppSizes.iconSize,
                color: AppColors.primaryColor,
              )
            : null,
        childrenPadding: EdgeInsets.only(
          top: 0.5.h,
          left: AppSizes.mediumWidth,
          right: AppSizes.mediumWidth,
          bottom: AppSizes.mediumHeight - 5,
        ),
        title: TText(
          text: title,
          fontWeight: AppSizes.wBold,
          fontSize: fontSize,
        ),
        children: children,
      ),
    );
  }
}
