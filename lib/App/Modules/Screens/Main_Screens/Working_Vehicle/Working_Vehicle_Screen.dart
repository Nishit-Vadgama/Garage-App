import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nv/Config/Config_Widgets/No_Data.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Images.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/Config_Widgets/Image_Widget.dart';
import '../../../../../Config/Config_Widgets/Text_Field.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import '../../../../Widgets/Car_Tile.dart';
import 'Working_Vehicle_Controller.dart';

class WorkingVehicleScreen extends StatelessWidget {
  const WorkingVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WorkingVehicleController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: TText(
          text: "Working Cars",
          fontSize: AppSizes.headingSize,
          fontColor: AppColors.white,
        ),
      ),
      body: Padding(
        padding: AppSizes.screenPadding,
        child: Column(
          spacing: AppSizes.mediumHeight,
          children: [
            // Search Car
            Row(
              spacing: AppSizes.mediumWidth,
              children: [
                Expanded(
                  child: ShadowTextField(
                    backgroundColor: AppColors.grey,
                    shadowBlur: 3,
                    isErrorShow: false,
                    label: "Search Car..",
                    textChangeFunction: (newValue) =>
                        controller.searchQuery.value = newValue.toLowerCase(),
                    // borderColor: AppColors.primaryColor.withOpacity(.8),
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageWidget(
                          image: AppImages.Find_Car,
                          height: 3.5.h,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: AppSizes.vBigIconSize,
                    color: AppColors.white,
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: AppColors.primary,
                          size: 30.sp,
                        ),
                      )
                    : controller.workingVehicles.isEmpty
                        ? No_Data(text: "No Working Vehicles Found")
                        : ListView.separated(
                            itemCount: controller.workingVehicles.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: AppSizes.s14),
                            itemBuilder: (context, index) => VehicleTile(
                                vehicle: controller.workingVehicles[index]),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
