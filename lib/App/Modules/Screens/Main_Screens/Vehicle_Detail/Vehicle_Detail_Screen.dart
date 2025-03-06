import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nv/Config/App_Configs/App_Functions.dart';
import 'package:nv/Config/Config_Widgets/Shadowed_Container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/Config_Widgets/App_List_Tile.dart';
import '../../../../../Config/Config_Widgets/Image_Widget.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import '../../../../Routes/App_Routes.dart';
import 'Vehicle_Detail_Controller.dart';

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(VehicleDetailController(vehicleId: Get.arguments));

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: TText(
          text: "Car Detail",
          fontColor: AppColors.whiteColor,
          fontSize: AppSizes.headingSize,
        ),
        actions: [
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
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor))
            : ListView(
                padding: AppSizes.screenPadding,
                children: [
                  ImageWidget(
                    image: controller.vehicle.vehicleImage.toString(),
                    height: 16.h,
                    radius: 12,
                    width: double.infinity,
                  ),
                  SizedBox(height: AppSizes.smallHeight),
                  AppListTile(
                    backgroundColor: AppColors.primaryPastelColor,
                    prefixIcon: Iconsax.car,
                    title: controller.vehicle.ownerName.toString(),
                    subTitle:
                        "${controller.vehicle.numberPlate.toString()}\n${controller.vehicle.ownerPhoneNumber.toString()}",
                    subtitleSize: AppSizes.f16,
                    titleColor: AppColors.primaryColor,
                    onTap: () {},
                    suffixWidget: ShadowedContainer(
                      onTap: () => AppFunctions.makePhoneCall(
                          controller.vehicle.ownerPhoneNumber ?? ""),
                      isCircle: true,
                      padding: EdgeInsets.all(AppSizes.s12),
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        Iconsax.call,
                        size: AppSizes.bigIconSize,
                        color: AppColors.primaryPastelColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
