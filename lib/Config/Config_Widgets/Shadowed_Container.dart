import 'package:flutter/material.dart';

import '../App_Configs/App_Colors.dart';
import '../App_Configs/App_Sizes.dart';

class ShadowedContainer extends StatelessWidget {
  final Color? backgroundColor, borderColor, shadowColor;
  final double? borderRadius, borderWidth, height, width, shadowBlur;
  final Widget child;
  final EdgeInsets? padding, margin;
  final bool isBorder, isCircle;
  final VoidCallback? onTap, longPress;
  const ShadowedContainer({
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.shadowColor,
    this.padding,
    required this.child,
    this.isBorder = false,
    this.onTap,
    this.height,
    this.width,
    this.shadowBlur,
    this.isCircle = false,
    this.margin,
    this.longPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.s12),
      onLongPress: longPress,
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.grey,
          border: isBorder == true
              ? Border.all(
                  color: borderColor ?? AppColors.grey,
                  width: borderWidth ?? 3,
                )
              : null,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle
              ? null
              : BorderRadius.circular(borderRadius ?? AppSizes.s12),
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? AppColors.shadow,
              blurRadius: shadowBlur ?? 5,
            )
          ],
        ),
        child: child,
      ),
    );
  }
}
