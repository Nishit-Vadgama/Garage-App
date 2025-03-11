import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nv/App/Database/Database_Services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Config/App_Configs/App_Colors.dart';
import '../../Config/App_Configs/App_Sizes.dart';
import '../../Config/Config_Widgets/Image_Widget.dart';
import '../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../Config/Config_Widgets/Text_Widget.dart';
import '../Model/Vehicle_Model.dart';
import '../Routes/App_Routes.dart';

Widget VehicleTile({required Vehicle vehicle}) {
  return ShadowedContainer(
    onTap: () => Get.toNamed(AppRoutes.VEHICLE_DETAIL,
        arguments: vehicle.vehicleId as String),
    backgroundColor: AppColors.pastel,
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
          backgroundColor: AppColors.white,
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
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 15.sp,
                    child: Icon(
                      Icons.person,
                      size: AppSizes.iconSize,
                      color: AppColors.pastel,
                    ),
                  ),
                  Expanded(
                    child: TText(
                      text: vehicle.ownerName.toString(),
                      maxLine: 2,
                      fontWeight: AppSizes.wBold,
                      fontColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: AppSizes.smallWidth,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 15.sp,
                    child: Icon(
                      Icons.drive_eta,
                      color: AppColors.pastel,
                      size: AppSizes.iconSize,
                    ),
                  ),
                  Expanded(
                    child: TText(
                      text: vehicle.numberPlate.toString(),
                      fontColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: AppSizes.smallWidth,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 15.sp,
                    child: Icon(
                      Icons.phone,
                      color: AppColors.pastel,
                      size: AppSizes.iconSize,
                    ),
                  ),
                  Expanded(
                    child: TText(
                      text: vehicle.ownerPhoneNumber.toString(),
                      fontColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: DatabaseServices.isRunningService(
              vehicleId: vehicle.vehicleId ?? ""),
          builder: (context, snapshot) => CircleAvatar(
            radius: 10.sp,
            backgroundColor:
                snapshot.data == true ? AppColors.green : Colors.transparent,
          ),
        )
      ],
    ),
  );
}
