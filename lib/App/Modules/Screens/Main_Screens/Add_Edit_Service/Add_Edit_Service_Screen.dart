import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/Config_Widgets/App_Button.dart';
import '../../../../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../../../../Config/Config_Widgets/Text_Field.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import '../../../../Model/Service_Model.dart';
import '../../../../Model/Work_Model.dart';
import 'Add_Edit_Service_Controller.dart';

class AddEditServiceScreen extends StatelessWidget {
  const AddEditServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Service? service = Get.arguments['service'] != null
        ? Service.fromJson(Get.arguments['service'])
        : null;
    final controller = Get.put(
      AddEditServiceController(
        service: service,
        vehicleId: Get.arguments['vehicleId'] ?? "",
      ),
    );
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.pastel,
        appBar: AppBar(
          title: TText(
            text: service != null ? "Edit Service" : "Add Service",
            fontColor: AppColors.white,
            fontSize: AppSizes.headingSize,
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.smallHeight, vertical: AppSizes.smallHeight),
          child: Column(
            spacing: AppSizes.smallHeight,
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadowedContainer(
                backgroundColor: AppColors.white,
                padding: AppSizes.defaultPadding,
                child: Column(
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
                            fontSize: AppSizes.headingSize,
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
                            fontSize: AppSizes.headingSize,
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
                            fontSize: AppSizes.headingSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppButton(
                onPress: controller.saveService,
                text: "Save",
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.mediumWidth),
          // padding: AppSizes.screenPadding,
          child: Form(
            key: controller.formKey,
            child: Column(
              spacing: AppSizes.smallHeight,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TText(
                      text: "Service Status",
                      fontColor: AppColors.primary,
                      fontWeight: AppSizes.wBold,
                    ),
                    Obx(
                      () => Switch(
                        activeColor: AppColors.primary,
                        inactiveThumbColor: AppColors.red,
                        inactiveTrackColor: AppColors.redPastle,
                        splashRadius: 20,
                        trackOutlineWidth: WidgetStatePropertyAll(0),
                        value: controller.isServiceDone.value,
                        onChanged: (newValue) =>
                            controller.isServiceDone.value = newValue,
                      ),
                    )
                  ],
                ),
                ShadowTextField(
                  controller: controller.problemController,
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Iconsax.attach_circle,
                        size: AppSizes.vBigIconSize,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  label: "Problems",
                  maxLines: 2,
                  minLines: 2,
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
                      text: "All Works",
                      fontCentered: false,
                      fontWeight: AppSizes.wBold,
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
                    () => ListView.separated(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSizes.smallHeight),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: AppSizes.smallHeight),
                        itemCount: controller.works.length,
                        itemBuilder: (context, index) {
                          Work work = controller.works[index];
                          return Column(
                            spacing: AppSizes.smallHeight,
                            children: [
                              ShadowedContainer(
                                padding: AppSizes.defaultPadding,
                                backgroundColor: AppColors.white,
                                shadowBlur: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShadowTextField(
                                      controller: TextEditingController(
                                          text: work.workTitle ?? ""),
                                      label: "Work",
                                      prefixIcon: Icon(
                                        Iconsax.receipt,
                                        size: AppSizes.bigIconSize,
                                        color: AppColors.primary,
                                      ),
                                      textChangeFunction: (newValue) {
                                        work.workTitle = newValue;
                                      },
                                    ),
                                    ShadowTextField(
                                      controller: TextEditingController(
                                          text: work.workDescription ?? ""),
                                      minLines: 2,
                                      maxLines: 2,
                                      label: "Description",
                                      textChangeFunction: (newValue) {
                                        work.workDescription = newValue;
                                      },
                                      prefixIcon: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Iconsax.message,
                                            size: AppSizes.bigIconSize,
                                            color: AppColors.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      spacing: AppSizes.mediumWidth,
                                      children: [
                                        Expanded(
                                          child: ShadowTextField(
                                            controller: TextEditingController(
                                                text: (work.itemCost ?? "")
                                                    .toString()),
                                            label: "Item Cost",
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.indianRupeeSign,
                                              size: AppSizes.iconSize,
                                              color: AppColors.primary,
                                            ),
                                            keyboardType: TextInputType.phone,
                                            textChangeFunction: (newValue) {
                                              work.itemCost = int.parse(
                                                  newValue.isEmpty
                                                      ? "0"
                                                      : newValue);
                                              controller.calculateTotal();
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: ShadowTextField(
                                            controller: TextEditingController(
                                                text: (work.serviceCost ?? "")
                                                    .toString()),
                                            label: "Service Cost",
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.indianRupeeSign,
                                              size: AppSizes.iconSize,
                                              color: AppColors.primary,
                                            ),
                                            keyboardType: TextInputType.phone,
                                            textChangeFunction: (newValue) {
                                              work.serviceCost = int.parse(
                                                  newValue.isEmpty
                                                      ? "0"
                                                      : newValue);
                                              controller.calculateTotal();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (index != 0)
                                      SizedBox(height: AppSizes.smallHeight),
                                    if (index != 0)
                                      SizedBox(
                                        width: double.infinity,
                                        child: RoundButton(
                                          borderColor: Colors.transparent,
                                          text: "Remove Work -",
                                          onPress: () =>
                                              controller.removeWork(index),
                                          textColor: AppColors.red,
                                          backgroundColor: AppColors.redPastle,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (controller.works.length - 1 == index)
                                SizedBox(
                                  width: double.infinity,
                                  child: RoundButton(
                                    text: "Add Work +",
                                    onPress: () => controller.addWork(),
                                    textColor: AppColors.primary,
                                    fontWeight: AppSizes.wBold,
                                    backgroundColor: AppColors.white,
                                    borderColor: AppColors.primary,
                                  ),
                                )
                            ],
                          );
                        }),
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
