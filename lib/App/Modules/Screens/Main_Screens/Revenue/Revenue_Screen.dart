import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:nv/App/AppHelper/App_Master_Data.dart';
import 'package:nv/App/Modules/Screens/Main_Screens/Revenue/Revenue_Controller.dart';
import 'package:nv/Config/App_Configs/App_Dialogs.dart';
import 'package:nv/Config/Config_Widgets/Shadowed_Container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RevenueController());
    return Scaffold(
      appBar: AppBar(
        title: TText(
          text: "Revenue",
          fontSize: AppSizes.headingSize,
          fontColor: AppColors.white,
        ),
      ),
      body: Padding(
        padding: AppSizes.screenPadding,
        child: Column(
          children: [
            ShadowedContainer(
              padding: AppSizes.defaultPadding,
              backgroundColor: AppColors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () async {
                          DateTime? temp = await AppDialogs.DatePicker(context);
                          if (temp != null) {
                            controller.fromDate.value = temp;
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TText(
                              text: "From Date",
                              fontSize: AppSizes.subtitleSize - 1,
                              fontColor: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: .5.h),
                            Container(
                              padding: EdgeInsets.all(11.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.pastel,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.calendar_bold,
                                    size: AppSizes.iconSize,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: AppSizes.smallWidth),
                                  TText(
                                    text: AppMasterData.dateToString(
                                        controller.fromDate.value),
                                    fontSize: AppSizes.titleSize,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: AppSizes.mediumHeight),
                      child: Divider(
                        color: AppColors.primary,
                        thickness: 3,
                        endIndent: AppSizes.smallWidth,
                        indent: AppSizes.smallWidth,
                      ),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () async {
                        DateTime? temp = await AppDialogs.DatePicker(context);
                        if (temp != null) {
                          controller.toDate.value = temp;
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TText(
                            text: "To Date",
                            fontSize: AppSizes.subtitleSize - 1,
                            fontColor: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: .5.h),
                          Container(
                            padding: EdgeInsets.all(11.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.pastel,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Iconsax.calendar_bold,
                                  size: AppSizes.iconSize,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: AppSizes.smallWidth),
                                TText(
                                  text: AppMasterData.dateToString(
                                      controller.toDate.value),
                                  fontSize: AppSizes.titleSize,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
