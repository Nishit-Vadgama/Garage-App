import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../App_Configs/App_Colors.dart';
import '../App_Configs/App_Sizes.dart';
import '../App_Configs/App_TextStyles.dart';
import 'Text_Widget.dart';

// All Application Buttons
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPress,
    this.text,
    this.weight = AppSizes.wBold,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.fontSize,
    this.isLoading = false,
    this.height,
    this.widget,
    this.width,
    this.padding,
    this.radius,
    this.borderColor = Colors.transparent,
  });

  final VoidCallback onPress;
  final String? text;
  final double? height, padding, radius, width, fontSize;
  final FontWeight weight;
  final Color backgroundColor, textColor, borderColor;
  final Widget? widget;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 29.sp,
      child: ElevatedButton(
        style: ButtonStyle(
          surfaceTintColor: WidgetStatePropertyAll(Colors.grey),
          alignment: Alignment.center,
          elevation: const WidgetStatePropertyAll(0),
          padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: padding ?? AppSizes.s12)),
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: radius != null
                  ? BorderRadius.circular(radius!)
                  : AppSizes.defaultBorderRadius,
              side: BorderSide(
                color: borderColor,
                width: 1.5,
              ),
            ),
          ),
        ),
        onPressed: isLoading ? null : onPress,
        child: isLoading
            ? Center(
                child: LoadingAnimationWidget.horizontalRotatingDots(
                  color: AppColors.whiteColor,
                  size: 25.sp,
                ),
              )
            : widget ??
                TText(
                  text: text!,
                  fontColor: textColor,
                  fontWeight: weight,
                  fontSize: fontSize,
                  textStyle: AppTextStyles.normalTextStyle,
                ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color? backgroundColor, textColor;
  final double? textSize;
  final bool isRightArrow;
  const RoundButton({
    super.key,
    required this.text,
    required this.onPress,
    this.backgroundColor,
    this.textColor,
    this.textSize,
    this.isRightArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(backgroundColor ?? Colors.transparent),
      ),
      onPressed: onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TText(
            text: text,
            fontWeight: FontWeight.bold,
            fontSize: textSize,
            fontColor: textColor ?? AppColors.textGrey,
          ),
          if (isRightArrow) SizedBox(width: AppSizes.smallWidth),
          if (isRightArrow)
            Icon(
              FontAwesomeIcons.chevronRight,
              size: AppSizes.iconSize,
              color: AppColors.primaryColor,
            )
        ],
      ),
    );
  }
}
