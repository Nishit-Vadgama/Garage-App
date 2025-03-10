import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nv/App/Model/Vehicle_Model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Dialogs.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/App_Configs/App_Strings.dart';
import '../../../../../Config/Config_Widgets/App_Button.dart';
import '../../../../../Config/Config_Widgets/Image_Widget.dart';
import '../../../../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../../../../Config/Config_Widgets/Snackbar.dart';
import '../../../../../Config/Config_Widgets/Text_Field.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import 'Add_Vehicle_Controller.dart';

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Vehicle? vehicle =
        Get.arguments != null ? Vehicle.fromJson(Get.arguments) : null;
    final controller = Get.put(AddVehicleController(vehicle: vehicle));
    return Scaffold(
      appBar: AppBar(
        title: TText(
          text: vehicle != null ? "Update Car" : "Add Car",
          fontSize: AppSizes.headingSize,
          fontColor: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Padding(
          padding: AppSizes.screenPadding,
          child: Form(
            key: controller.addCarFromKey,
            child: Column(
              children: [
                // Vehicle Image
                MediaShow(controller: controller),
                SizedBox(height: AppSizes.mediumHeight),

                // Owner Name
                ShadowTextField(
                  controller: controller.vehicleOwnerName,
                  label: "Name",
                  prefixIcon: Icon(
                    Iconsax.user,
                    size: AppSizes.bigIconSize,
                    color: AppColors.primary,
                  ),
                ),

                // Owner Mobile Number
                ShadowTextField(
                  controller: controller.vehicleOwnerPhoneNumber,
                  label: "Mobile Number",
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  prefixIcon: Icon(
                    Iconsax.call,
                    size: AppSizes.bigIconSize,
                    color: AppColors.primary,
                  ),
                ),

                // Number Plate
                ShadowTextField(
                  controller: controller.vehicleNumberPlate,
                  label: "Number Plate",
                  prefixIcon: Icon(
                    Iconsax.personalcard,
                    size: AppSizes.bigIconSize,
                    color: AppColors.primary,
                  ),
                  inputFormatters: [NumberPlateInputFormatter()],
                ),

                // Vehicle Model
                ShadowTextField(
                  controller: controller.vehicleModel,
                  label: "Model",
                  prefixIcon: Icon(
                    Iconsax.car,
                    size: AppSizes.bigIconSize,
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: AppSizes.bigHeight),

                Obx(
                  () => AppButton(
                    onPress: controller.saveVehicle,
                    text: vehicle != null ? "Update" : "Add",
                    isLoading: controller.isLoading.value,
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

class MediaShow extends StatelessWidget {
  final AddVehicleController controller;
  final String title;

  const MediaShow({
    super.key,
    required this.controller,
    this.title = "Select Car Image",
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ShadowedContainer(
        onTap: () async {
          final String? pickedImage = await AppDialogs.Single_Image_Picker();
          if (pickedImage != null) {
            controller.vehicleImage.value = pickedImage;
          } else {
            App_Snackbar(
              type: false,
              msg: AppStrings.No_File_Selected,
            );
          }
        },
        height: 17.h,
        shadowColor: AppColors.primary,
        width: double.infinity,
        backgroundColor: AppColors.pastel,
        child: controller.vehicleImage.isNotEmpty
            ? Stack(
                children: [
                  ImageWidget(
                    image: controller.vehicleImage.value,
                    height: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 28.w,
                    child: Container(
                      padding: EdgeInsets.all(AppSizes.s10),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                        color: AppColors.black,
                      ),
                      child: Row(
                        spacing: AppSizes.mediumWidth,
                        children: [
                          Icon(
                            Iconsax.refresh,
                            size: AppSizes.bigIconSize,
                            color: AppColors.red,
                          ),
                          TText(
                            text: AppStrings.Change_Image,
                            fontSize: AppSizes.smallSubtitleSize,
                            fontColor: AppColors.white,
                            fontWeight: AppSizes.wBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                spacing: AppSizes.smallHeight,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.gallery,
                    size: AppSizes.vBigIconSize + AppSizes.s6,
                    color: AppColors.primary,
                  ),
                  TText(
                    text: title,
                    fontWeight: AppSizes.wBold,
                    fontColor: AppColors.primary,
                  ),
                ],
              ),
      ),
    );
  }
}
