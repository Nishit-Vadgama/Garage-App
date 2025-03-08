import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../App_Configs/App_Colors.dart';
import '../App_Configs/App_Dialogs.dart';
import '../App_Configs/App_Sizes.dart';
import 'Text_Widget.dart';

// ########## NORMAL BORDERED TEXT FIELD #########
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.keyboardType = TextInputType.name,
    this.prefixIcon,
    this.obscure = false,
    this.focusColor = AppColors.primaryColor,
    this.maxLength,
    this.radius = 10,
    this.isReadOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.isCapitalWords = false,
    this.initialValue,
    this.suffixIcon,
    this.validator,
    this.inputFormatters,
    this.submittedFunction,
    this.textChangeFunction,
    this.padding,
    this.labelColor,
  });

  final TextEditingController? controller;
  final String? label;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscure;
  final Color focusColor;
  final int? maxLength;
  final double radius;
  final bool isReadOnly;
  final int minLines;
  final int maxLines;
  final bool? isCapitalWords;
  final String? initialValue;
  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? submittedFunction;
  final void Function(String)? textChangeFunction;
  final EdgeInsets? padding;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: obscure,
      style: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
      ),
      onFieldSubmitted: submittedFunction,
      onChanged: textChangeFunction,
      textInputAction: TextInputAction.next,
      validator: validator,
      cursorColor: AppColors.whiteColor,
      controller: controller,
      textCapitalization: isCapitalWords == true
          ? TextCapitalization.words
          : TextCapitalization.none,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: padding ?? AppSizes.defaultPadding,
        counterText: "",
        focusColor: AppColors.primaryColor,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.all(AppSizes.s16),
                child: prefixIcon,
              )
            : null,
        suffixIcon: suffixIcon,
        label: label != null ? TText(text: label!) : null,
        labelStyle: TextStyle(
          color: labelColor ?? AppColors.textGrey,
          fontWeight: AppSizes.wBold,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: AppColors.redColor,
            width: 1.5,
          ),
        ),
        errorStyle: const TextStyle(fontSize: 0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: focusColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: AppColors.textGrey, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: AppColors.greyColor, width: 1.5),
        ),
      ),
    );
  }
}

// ########## SHADOWED TEXT FIELD #########
class ShadowTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscure, isReadOnly, isErrorShow;
  final VoidCallback? onTap;
  final int? maxLength;
  final double radius;
  final double? hintSize;
  final int minLines;
  final int maxLines, shadowBlur;
  final bool? isCapitalWords;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? submittedFunction;
  final void Function(String)? textChangeFunction;
  final EdgeInsets? padding;
  final Color? labelColor, focusColor, backgroundColor, borderColor;
  final TextInputAction textInputAction;

  const ShadowTextField({
    super.key,
    this.controller,
    this.label,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscure = false,
    this.radius = 10,
    this.minLines = 1,
    this.maxLines = 1,
    this.isCapitalWords = true,
    this.maxLength,
    this.validator,
    this.inputFormatters,
    this.submittedFunction,
    this.textChangeFunction,
    this.padding,
    this.labelColor,
    this.focusColor,
    this.shadowBlur = 3,
    this.isReadOnly = false,
    this.onTap,
    this.isErrorShow = true,
    this.textInputAction = TextInputAction.next,
    this.hintSize,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final isFocused = false.obs;
    final errorText = ''.obs;

    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });

    return Obx(
      () {
        final currentShadowColor = isReadOnly
            ? AppColors.shadowColor
            : isFocused.value
                ? focusColor ?? AppColors.primaryColor
                : AppColors.shadowColor;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: backgroundColor ?? AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: currentShadowColor,
                    blurStyle: BlurStyle.outer,
                    blurRadius: double.parse(shadowBlur.toString()),
                  ),
                ],
                border: Border.all(
                    color: borderColor ?? Colors.transparent, width: 1.5),
                borderRadius: AppSizes.defaultBorderRadius,
              ),
              child: TextFormField(
                onTap: onTap,
                readOnly: isReadOnly,
                focusNode: focusNode,
                minLines: minLines,
                maxLines: maxLines,
                maxLength: maxLength,
                obscureText: obscure,
                controller: controller,
                style: TextStyle(
                  fontSize: AppSizes.titleSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                ),
                onFieldSubmitted: submittedFunction,
                onChanged: textChangeFunction,
                textInputAction: textInputAction,
                validator: (value) {
                  var error = validator?.call(value);

                  if (value.toString().isEmpty) {
                    error = "$label is Required";
                  }
                  if (error != null) {
                    return errorText.value = error;
                  } else {
                    errorText.value = "";
                    return null;
                  }
                },
                cursorColor: AppColors.primaryColor,
                textCapitalization: isCapitalWords == true
                    ? TextCapitalization.words
                    : TextCapitalization.none,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  suffixIcon: suffixIcon != null
                      ? Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppSizes.s12),
                          child: suffixIcon,
                        )
                      : suffixIcon,
                  prefixIcon: prefixIcon != null
                      ? Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppSizes.s12),
                          child: prefixIcon,
                        )
                      : null,
                  errorStyle: TextStyle(fontSize: 0),
                  contentPadding: padding ?? AppSizes.defaultPadding,
                  hintText: label,
                  hintStyle: TextStyle(
                    fontWeight: AppSizes.wBold,
                    fontSize: hintSize ?? AppSizes.titleSize,
                    color: labelColor ?? AppColors.textGrey,
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
            if (isErrorShow)
              Container(
                padding: EdgeInsets.only(top: .2.h),
                height: AppSizes.mediumHeight,
                child: errorText.value.isNotEmpty
                    ? TText(
                        text: errorText.value,
                        fontSize: AppSizes.smallSubtitleSize - 1,
                        fontColor: AppColors.redColor,
                        fontWeight: AppSizes.wBold,
                      )
                    : null,
              )
          ],
        );
      },
    );
  }
}

// ########## DATE OF BIRTH TEXT FIELD (WITH DATE PICKER) #########
class DobTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? focusColor;
  final int? maxLength;
  final double shadowBlur;
  final bool isReadOnly;
  final int minLines;
  final int maxLines;
  final bool? isCapitalWords;
  final String? initialValue;
  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? padding;

  const DobTextField({
    super.key,
    required this.controller,
    this.label,
    this.prefixIcon,
    this.focusColor,
    this.maxLength,
    this.isReadOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.isCapitalWords = false,
    this.initialValue,
    this.suffixIcon,
    this.validator,
    this.inputFormatters,
    this.padding,
    this.shadowBlur = 3,
  });

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final isFocused = false.obs;
    final errorText = ''.obs;

    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });

    return Obx(() {
      final currentShadowColor = isFocused.value
          ? focusColor ?? AppColors.primaryColor
          : AppColors.shadowColor;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: currentShadowColor,
                  blurStyle: BlurStyle.outer,
                  blurRadius: shadowBlur,
                ),
              ],
              borderRadius: AppSizes.defaultBorderRadius,
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              textCapitalization: isCapitalWords == true
                  ? TextCapitalization.words
                  : TextCapitalization.none,
              maxLength: maxLength ?? 10,
              validator: (value) {
                final error = validator?.call(value);
                if (error != null) {
                  return errorText.value = error;
                } else {
                  errorText.value = "";
                  return null;
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: "",
                errorStyle: const TextStyle(fontSize: 0),
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.s12),
                        child: prefixIcon,
                      )
                    : null,
                suffixIcon: suffixIcon ??
                    IconButton(
                      icon: Icon(
                        Iconsax.calendar_2,
                        size: AppSizes.iconSize + 5,
                        color: AppColors.primaryColor,
                      ),
                      style: ButtonStyle(
                          overlayColor:
                              WidgetStatePropertyAll(Colors.transparent),
                          visualDensity: VisualDensity.compact,
                          padding: WidgetStatePropertyAll(
                              EdgeInsets.only(right: AppSizes.mediumWidth))),
                      onPressed: () async {
                        String? pickedDate =
                            await AppDialogs.DatePicker(context);
                        if (pickedDate != null) {
                          controller.text = pickedDate;
                        }
                      },
                    ),
                hintText: label ?? "DD-MM-YYYY",
                contentPadding: padding ?? AppSizes.defaultPadding,
                hintStyle: TextStyle(
                  fontWeight: AppSizes.wBold,
                  fontSize: AppSizes.titleSize,
                  color: AppColors.textGrey,
                ),
              ),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: AppSizes.titleSize,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
              keyboardType: TextInputType.number,
              cursorColor: AppColors.primaryColor,
              inputFormatters: inputFormatters ??
                  [
                    FilteringTextInputFormatter.digitsOnly,
                    DateInputFormatter(),
                  ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: .2.h),
            height: AppSizes.mediumHeight,
            child: errorText.value.isNotEmpty
                ? TText(
                    text: errorText.value,
                    fontSize: AppSizes.smallSubtitleSize - 1,
                    fontColor: AppColors.redColor,
                    fontWeight: AppSizes.wBold,
                  )
                : null,
          )
        ],
      );
    });
  }
}

// ########## DATE FORMATTED TEXT #########
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    String formattedText = text;
    if (text.length >= 3 && text[2] != '-') {
      formattedText = '${text.substring(0, 2)}-${text.substring(2)}';
    }
    if (formattedText.length >= 6 && formattedText[5] != '-') {
      formattedText =
          '${formattedText.substring(0, 5)}-${formattedText.substring(5)}';
    }

    if (formattedText.length > 10) {
      formattedText = formattedText.substring(0, 10);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

// ########## NUMBER PLATE FORMATTED TEXT #########
class NumberPlateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text =
        newValue.text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

    String formattedText = '';

    if (text.length > 2) {
      formattedText = '${text.substring(0, 2)}-';
      if (text.length > 4) {
        formattedText += '${text.substring(2, 4)}-';
        if (text.length > 6) {
          formattedText += '${text.substring(4, 6)}-';
          if (text.length > 10) {
            formattedText += text.substring(6, 10);
          } else {
            formattedText += text.substring(6);
          }
        } else {
          formattedText += text.substring(4);
        }
      } else {
        formattedText += text.substring(2);
      }
    } else {
      formattedText = text;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
