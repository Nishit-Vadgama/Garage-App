import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Functions.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/Config_Widgets/App_List_Tile.dart';
import '../../../../../Config/Config_Widgets/Image_Widget.dart';
import '../../../../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import '../../../../AppHelper/App_Master_Data.dart';
import '../../../../Model/Service_Model.dart';
import '../../../../Routes/App_Routes.dart';
import 'Vehicle_Detail_Controller.dart';

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(VehicleDetailController(vehicleId: Get.arguments.toString()));

    return Scaffold(
      appBar: AppBar(
        title: TText(
          text: "Car Detail",
          fontColor: AppColors.white,
          fontSize: AppSizes.headingSize,
        ),
        actions: [
          // Edit Car Details
          IconButton(
            onPressed: () => Get.toNamed(
              AppRoutes.ADD_VEHICLE,
              arguments: controller.vehicle.toJson(),
            ),
            icon: Icon(
              Iconsax.edit,
              size: AppSizes.bigIconSize,
            ),
          ),
          SizedBox(
            width: AppSizes.mediumWidth,
          )
        ],
      ),
      // Add Services
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Service",
        backgroundColor: AppColors.primary,
        onPressed: () => Get.toNamed(AppRoutes.ADD_SERVICE),
        child: Icon(
          Iconsax.add,
          size: AppSizes.vBigIconSize + AppSizes.s8,
          color: AppColors.pastel,
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.pastel,
        color: AppColors.primary,
        onRefresh: () async {
          await controller.getVehicleById();
          await controller.getVehicleServices();
        },
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primary))
              : Padding(
                  padding: AppSizes.screenPadding,
                  child: Column(
                    spacing: AppSizes.smallHeight,
                    children: [
                      // Car Image
                      ImageWidget(
                        image: controller.vehicle.vehicleImage.toString(),
                        height: 16.h,
                        radius: 12,
                        width: double.infinity,
                      ),
                      AppListTile(
                        backgroundColor: AppColors.pastel,
                        prefixIcon: Iconsax.car,
                        title: controller.vehicle.ownerName.toString(),
                        subTitle:
                            "${controller.vehicle.numberPlate.toString()}\n${controller.vehicle.ownerPhoneNumber.toString()}",
                        subtitleSize: AppSizes.f16,
                        titleColor: AppColors.primary,
                        onTap: () {},
                        suffixWidget: ShadowedContainer(
                          onTap: () => AppFunctions.makePhoneCall(
                              controller.vehicle.ownerPhoneNumber ?? ""),
                          isCircle: true,
                          padding: EdgeInsets.all(AppSizes.s12),
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Iconsax.call,
                            size: AppSizes.bigIconSize,
                            color: AppColors.pastel,
                          ),
                        ),
                      ),
                      Row(
                        spacing: AppSizes.mediumWidth,
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.primary,
                              thickness: 2,
                            ),
                          ),
                          TText(
                            text: "All Services",
                            fontCentered: false,
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Obx(
                          () => controller.serviceLoading.value
                              ? Center(
                                  child: LoadingAnimationWidget
                                      .horizontalRotatingDots(
                                    color: AppColors.primary,
                                    size: 30.sp,
                                  ),
                                )
                              : ListView.separated(
                                  padding: EdgeInsets.zero,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: AppSizes.smallHeight),
                                  itemCount: controller.vehicleServices.length,
                                  itemBuilder: (context, index) {
                                    Service service =
                                        controller.vehicleServices[index];
                                    return ShadowedContainer(
                                      onTap: () => Get.toNamed(
                                        AppRoutes.ADD_SERVICE,
                                        arguments: {
                                          "service": service.toJson(),
                                          "vehicleId": controller.vehicleId
                                        },
                                      ),
                                      backgroundColor: AppColors.white,
                                      padding: AppSizes.defaultPadding,
                                      shadowBlur: 0,
                                      child: Row(
                                        spacing: AppSizes.mediumWidth,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppColors.primary,
                                            child: Icon(
                                              Iconsax.calendar_1,
                                              size: AppSizes.bigIconSize,
                                              color: AppColors.pastel,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              spacing: AppSizes.smallHeight,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TText(
                                                  text: AppMasterData
                                                      .formatTimestamp(
                                                    service.endDate ??
                                                        Timestamp.now(),
                                                  ),
                                                  fontColor: AppColors.primary,
                                                  fontWeight: AppSizes.wBold,
                                                ),
                                                TText(
                                                  text: service.problems
                                                      .toString(),
                                                  maxLine: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 10.sp,
                                            backgroundColor:
                                                service.isDone == false
                                                    ? AppColors.green
                                                    : Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
