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
import 'Find_Vehicle_Controller.dart';

class FindVehicleScreen extends StatelessWidget {
  const FindVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FindVehicleController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: TText(
          text: "Find Car",
          fontColor: AppColors.white,
          fontSize: AppSizes.headingSize,
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.pastel,
        color: AppColors.primary,
        onRefresh: () => controller.getAllVehicles(),
        child: Padding(
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
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.primary),
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
                      : controller.allVehicles.isEmpty
                          ? No_Data(text: "No Vehicles Found")
                          : ListView.separated(
                              itemCount: controller.allVehicles.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: AppSizes.s14),
                              itemBuilder: (context, index) => VehicleTile(
                                  vehicle: controller.allVehicles[index]),
                            ),
                ),
              )
              //
              // Expanded(
              //   child: StreamBuilder<List<Vehicle>>(
              //     stream: DatabaseServices.getAllVehicles(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(child: CircularProgressIndicator());
              //       }
              //       if (snapshot.hasError) {
              //         return Center(child: Text('Error: ${snapshot.error}'));
              //       }
              //       if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //         return Center(child: Text('No vehicles found'));
              //       }
              //
              //       return Obx(
              //         () {
              //           List<Vehicle> allVehicles = snapshot.data!;
              //           // Filter vehicles based on search query
              //           RxList<Vehicle> filteredVehicles = allVehicles
              //               .where((vehicle) {
              //                 return vehicle.numberPlate
              //                         .toString()
              //                         .toLowerCase()
              //                         .contains(controller.searchQuery.value) ||
              //                     vehicle.ownerName
              //                         .toString()
              //                         .toLowerCase()
              //                         .contains(controller.searchQuery.value);
              //               })
              //               .toList()
              //               .obs;
              //
              //           // Show message if no results match the search
              //           if (filteredVehicles.isEmpty) {
              //             return Center(
              //                 child: Text('No matching vehicles found'));
              //           } else {
              //             return Obx(
              //               () => ListView.separated(
              //                 itemCount: filteredVehicles.length,
              //                 separatorBuilder: (context, index) =>
              //                     SizedBox(height: AppSizes.s14),
              //                 itemBuilder: (context, index) =>
              //                     VehicleTile(vehicle: filteredVehicles[index]),
              //               ),
              //             );
              //           }
              //         },
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
