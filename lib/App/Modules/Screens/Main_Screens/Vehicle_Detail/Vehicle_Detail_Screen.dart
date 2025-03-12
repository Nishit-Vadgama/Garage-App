import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nv/Config/Config_Widgets/Full_Screen_Image_Screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Functions.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/Config_Widgets/App_List_Tile.dart';
import '../../../../../Config/Config_Widgets/Image_Widget.dart';
import '../../../../../Config/Config_Widgets/No_Data.dart';
import '../../../../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import '../../../../Model/Service_Model.dart';
import '../../../../Routes/App_Routes.dart';
import '../../../../Widgets/Service_Tile.dart';
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
        onPressed: () => Get.toNamed(AppRoutes.ADD_SERVICE,
            arguments: {"vehicleId": controller.vehicleId}),
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
                  child: SingleChildScrollView(
                    physics:
                        AlwaysScrollableScrollPhysics(), // Ensures refresh always works
                    child: Column(
                      spacing: AppSizes.smallHeight,
                      children: [
                        // Car Image
                        InkWell(
                          onTap: () => Get.to(FullScreenImageScreen(
                              image:
                                  controller.vehicle.vehicleImage.toString())),
                          child: Hero(
                            tag: controller.vehicle.vehicleImage.toString(),
                            child: Material(
                              color: Colors.transparent,
                              child: ImageWidget(
                                image:
                                    controller.vehicle.vehicleImage.toString(),
                                height: 16.h,
                                radius: 12,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        AppListTile(
                          backgroundColor: AppColors.pastel,
                          prefixIcon: Iconsax.car,
                          title: controller.vehicle.ownerName.toString(),
                          subTitle:
                              "${controller.vehicle.numberPlate}\n${controller.vehicle.ownerPhoneNumber}",
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
                        Obx(
                          () => controller.serviceLoading.value
                              ? Center(
                                  child: LoadingAnimationWidget
                                      .horizontalRotatingDots(
                                    color: AppColors.primary,
                                    size: 30.sp,
                                  ),
                                )
                              : controller.vehicleServices.isEmpty
                                  ? No_Data(text: "No Services Found")
                                  : ListView.separated(
                                      padding: EdgeInsets.zero,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                              height: AppSizes.smallHeight),
                                      itemCount:
                                          controller.vehicleServices.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        Service service =
                                            controller.vehicleServices[index];
                                        return Service_Tile(
                                          service: service,
                                          vehicleId: controller.vehicleId,
                                        );
                                      },
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
