import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nv/Config/Config_Widgets/App_Button.dart';
import 'package:nv/Config/Config_Widgets/Shadowed_Container.dart';
import 'package:nv/Config/Config_Widgets/Text_Field.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import 'Add_Service_Controller.dart';

class AddServiceScreen extends StatelessWidget {
  const AddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddServiceController());
    return Scaffold(
      backgroundColor: AppColors.pastel,
      appBar: AppBar(
        title: TText(
          text: "Add Service",
          fontColor: AppColors.white,
          fontSize: AppSizes.headingSize,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        tooltip: "Edit Service",
        onPressed: () {},
        child: Icon(
          Iconsax.edit,
          size: AppSizes.bigIconSize,
          color: AppColors.white,
        ),
      ),
      body: Padding(
        padding: AppSizes.screenPadding,
        child: Column(
          children: [
            AppButton(
              onPress: () {},
              text: "Service Done ✅",
            ),
            SizedBox(height: AppSizes.mediumHeight),
            ShadowTextField(
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
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.mediumHeight),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(height: AppSizes.smallHeight),
                itemCount: 10,
                itemBuilder: (context, index) => ShadowedContainer(
                  padding: AppSizes.defaultPadding,
                  backgroundColor: AppColors.white,
                  shadowBlur: 0,
                  child: TText(text: "text"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
