import 'package:flutter/material.dart';

import '../App_Configs/App_TextStyles.dart';

class TText extends StatelessWidget {
  const TText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontColor,
    this.fontWeight,
    this.fontCentered = false,
    this.maxLine = 1,
    this.latterSpacing,
    this.textAlign,
    this.textStyle,
  });

  final String text;
  final double? fontSize, latterSpacing;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final bool fontCentered;
  final TextAlign? textAlign;
  final int? maxLine;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: fontCentered ? TextAlign.center : textAlign ?? TextAlign.start,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: textStyle?.copyWith(
            letterSpacing: latterSpacing,
            fontSize: fontSize,
            color: fontColor,
            fontWeight: fontWeight,
          ) ??
          AppTextStyles.normalTextStyle.copyWith(
            letterSpacing: latterSpacing,
            fontSize: fontSize,
            color: fontColor,
            fontWeight: fontWeight,
            overflow: TextOverflow.ellipsis,
          ),
    );
  }
}
