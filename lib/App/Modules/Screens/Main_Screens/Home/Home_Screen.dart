import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/App_Configs/App_Strings.dart';
import '../../../../../Config/Config_Widgets/Image_Widget.dart';
import '../../../../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import 'Home_Controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: TText(
          text: AppStrings.Home,
          fontColor: Colors.white,
          fontSize: AppSizes.headingSize,
        ),
      ),
      body: GridView.builder(
        padding: AppSizes.screenPadding,
        itemCount: controller.homeList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 47.sp,
          mainAxisSpacing: 15.sp,
          crossAxisSpacing: 15.sp,
        ),
        itemBuilder: (context, index) => ShadowedContainer(
          onTap: () => Get.toNamed(controller.homeList[index]["screen"]),
          padding: AppSizes.defaultPadding,
          backgroundColor: AppColors.primaryPastelColor,
          shadowBlur: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TText(
                text: controller.homeList[index]["title"],
                fontWeight: AppSizes.wBold,
                fontColor: AppColors.primaryColor,
              ),
              SizedBox(height: AppSizes.smallHeight),
              ImageWidget(
                image: controller.homeList[index]["image"],
                height: 6.5.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
