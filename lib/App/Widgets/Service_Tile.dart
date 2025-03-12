import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Config/App_Configs/App_Colors.dart';
import '../../Config/App_Configs/App_Sizes.dart';
import '../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../Config/Config_Widgets/Text_Widget.dart';
import '../AppHelper/App_Master_Data.dart';
import '../Model/Service_Model.dart';
import '../Routes/App_Routes.dart';

Widget Service_Tile({required Service service, required String vehicleId}) {
  return ShadowedContainer(
    onTap: () => Get.toNamed(
      AppRoutes.ADD_SERVICE,
      arguments: {"service": service.toJson(), "vehicleId": vehicleId},
    ),
    backgroundColor: AppColors.white,
    padding: AppSizes.defaultPadding,
    shadowBlur: 0,
    child: Row(
      spacing: AppSizes.mediumWidth,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primary,
          radius: 18,
          child: Icon(
            Iconsax.calendar_1,
            size: AppSizes.bigIconSize,
            color: AppColors.pastel,
          ),
        ),
        Expanded(
          child: Column(
            spacing: AppSizes.smallHeight,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: AppSizes.smallWidth,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.s12, vertical: AppSizes.s6),
                      decoration: BoxDecoration(
                        color: AppColors.pastel,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TText(
                            text: "From",
                            fontSize: AppSizes.subtitleSize,
                          ),
                          TText(
                            text: AppMasterData.formatTimestamp(
                              service.startDate ?? Timestamp.now(),
                            ),
                            fontColor: AppColors.primary,
                            fontWeight: AppSizes.wBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 8.w,
                    height: .3.h,
                    decoration: BoxDecoration(color: AppColors.primary),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.s12, vertical: AppSizes.s6),
                      decoration: BoxDecoration(
                        color: AppColors.pastel,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TText(
                            text: "To",
                            fontSize: AppSizes.subtitleSize,
                          ),
                          TText(
                            text: service.endDate != null
                                ? AppMasterData.formatTimestamp(
                                    service.endDate!)
                                : "In Working",
                            fontColor: AppColors.primary,
                            fontWeight: AppSizes.wBold,
                            fontSize: AppSizes.f16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TText(
                text: service.problems.toString(),
                maxLine: 5,
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 10.sp,
          backgroundColor:
              service.isDone == false ? AppColors.primary : Colors.transparent,
        ),
      ],
    ),
  );
}
