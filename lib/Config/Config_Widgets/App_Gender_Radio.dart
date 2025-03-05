import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../App_Configs/App_Colors.dart';
import '../App_Configs/App_Sizes.dart';
import 'Shadowed_Container.dart';
import 'Text_Widget.dart';

Widget AppGenderRadio({
  required String groupValue,
  List<String> options = const ["Male", "Female"],
  required Function(String) onChanged,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: options.map((option) {
      return Expanded(
        child: ShadowedContainer(
          height: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: AppSizes.smallWidth),
          padding: EdgeInsets.all(AppSizes.s10),
          onTap: () => onChanged(option),
          backgroundColor: AppColors.whiteColor,
          child: Row(
            children: [
              Transform.scale(
                scale: MediaQuery.of(Get.context!).size.width > 700 ? 1.5 : 1,
                child: Radio<String>(
                  value: option,
                  groupValue: groupValue,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) => onChanged(value!),
                  activeColor: AppColors.primaryColor,
                ),
              ),
              SizedBox(width: AppSizes.s6),
              TText(text: option),
            ],
          ),
        ),
      );
    }).toList(),
  );
}
