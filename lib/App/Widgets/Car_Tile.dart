import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nv/App/Routes/App_Routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Config/App_Configs/App_Colors.dart';
import '../../Config/App_Configs/App_Sizes.dart';
import '../../Config/Config_Widgets/Image_Widget.dart';
import '../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../Config/Config_Widgets/Text_Widget.dart';
import '../Model/Vehicle_Model.dart';

Widget CarTile({required Vehicle vehicle}) {
  return ShadowedContainer(
    onTap: () =>
        Get.toNamed(AppRoutes.VEHICLE_DETAIL, arguments: vehicle.vehicleId),
    backgroundColor: AppColors.primaryPastelColor,
    shadowBlur: 0,
    padding: AppSizes.defaultPadding,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.mediumWidth,
      children: [
        ImageWidget(
          image: vehicle.vehicleImage.toString(),
          height: 40.sp,
          fit: BoxFit.cover,
          backgroundColor: AppColors.whiteColor,
          radius: 12,
        ),
        Expanded(
          child: Column(
            spacing: AppSizes.smallHeight,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: AppSizes.smallWidth,
                children: [
                  Icon(
                    Icons.person,
                    color: AppColors.blackColor,
                  ),
                  TText(
                    text: vehicle.ownerName.toString(),
                    fontWeight: AppSizes.wBold,
                    fontColor: AppColors.primaryColor,
                  ),
                ],
              ),
              Row(
                spacing: AppSizes.smallWidth,
                children: [
                  Icon(
                    Icons.drive_eta,
                    color: AppColors.blackColor,
                  ),
                  TText(
                    text: vehicle.numberPlate.toString(),
                    fontColor: AppColors.primaryColor,
                  ),
                ],
              ),
              Row(
                spacing: AppSizes.smallWidth,
                children: [
                  Icon(
                    Icons.phone,
                    color: AppColors.blackColor,
                  ),
                  TText(
                    text: vehicle.ownerPhoneNumber.toString(),
                    fontColor: AppColors.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 10.sp,
          backgroundColor: vehicle.inWorkShop == true
              ? AppColors.successColor
              : AppColors.redColor,
        ),
      ],
    ),
  );
}
