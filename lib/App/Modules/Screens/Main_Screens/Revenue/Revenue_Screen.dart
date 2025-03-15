import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Dialogs.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/Config_Widgets/No_Data.dart';
import '../../../../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import '../../../../AppHelper/App_Master_Data.dart';
import '../../../../Widgets/Service_Tile.dart';
import 'Revenue_Controller.dart';

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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.smallHeight, vertical: AppSizes.smallHeight),
        child: ShadowedContainer(
          backgroundColor: AppColors.white,
          padding: AppSizes.defaultPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TText(
                    text: "Total",
                    fontWeight: AppSizes.wBold,
                  ),
                  Obx(
                    () => TText(
                      text: "${controller.total.value} ₹",
                      fontColor: AppColors.primary,
                      fontWeight: AppSizes.wBold,
                      fontSize: AppSizes.headingSize - 1,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TText(
                    text: "Services Total",
                    fontWeight: AppSizes.wBold,
                  ),
                  Obx(
                    () => TText(
                      text: "${controller.servicesTotal.value} ₹",
                      fontColor: AppColors.primary,
                      fontWeight: AppSizes.wBold,
                      fontSize: AppSizes.headingSize - 1,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TText(
                    text: "Items Cost",
                    fontWeight: AppSizes.wBold,
                  ),
                  Obx(
                    () => TText(
                      text: "${controller.itemsTotal.value} ₹",
                      fontColor: AppColors.primary,
                      fontWeight: AppSizes.wBold,
                      fontSize: AppSizes.headingSize - 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.pastel,
        color: AppColors.primary,
        onRefresh: () => controller.getAllServices(),
        child: Padding(
          padding: AppSizes.screenPadding,
          child: Column(
            spacing: AppSizes.mediumHeight,
            children: [
              // Pick From And To Date
              ShadowedContainer(
                padding: AppSizes.defaultPadding,
                backgroundColor: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            DateTime? temp =
                                await AppDialogs.DatePicker(context);
                            if (temp != null) {
                              controller.fromDate.value = temp;
                            }
                            controller.getAllServices();
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
                          controller.getAllServices();
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

              // Show All Services
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: LoadingAnimationWidget.horizontalRotatingDots(
                              color: AppColors.primary, size: 30.sp))
                      : controller.allService.isEmpty
                          ? No_Data(text: "No Services Found")
                          : ListView.separated(
                              itemCount: controller.allService.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: AppSizes.smallHeight),
                              itemBuilder: (context, index) => Service_Tile(
                                  service: controller.allService[index])),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
