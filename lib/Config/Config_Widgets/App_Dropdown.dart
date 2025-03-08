import 'package:flutter/material.dart';

import '../App_Configs/App_Colors.dart';
import '../App_Configs/App_Dialogs.dart';
import '../App_Configs/App_Sizes.dart';
import 'Shadowed_Container.dart';
import 'Text_Widget.dart';

class AppDropDown<T> extends StatelessWidget {
  final String hint;
  final String? value;
  final List<T> items;
  final double? height;
  final double? width;
  final bool Function(T, String) filterCondition;
  final Widget Function(T) itemBuilder;
  const AppDropDown({
    super.key,
    required this.hint,
    required this.items,
    this.value,
    this.height,
    this.width,
    required this.filterCondition,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      height: height,
      width: width,
      onTap: () async => await AppDialogs.showDropdownDialog<T>(
          items: items,
          hint: hint,
          filterCondition: filterCondition,
          itemBuilder: itemBuilder,
          ),
      borderRadius: AppSizes.s12,
      backgroundColor: AppColors.whiteColor,
      padding: AppSizes.defaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TText(
              text: value == null || value!.isEmpty ? hint : value!,
              fontColor: value == null || value!.isEmpty
                  ? AppColors.textGrey
                  : AppColors.blackColor,
              fontWeight: AppSizes.wBold,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: AppSizes.bigIconSize,
            color: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}
