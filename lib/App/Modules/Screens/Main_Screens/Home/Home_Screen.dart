import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Images.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/App_Configs/App_Strings.dart';
import '../../../../../Config/Config_Widgets/Image_Widget.dart';
import '../../../../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return RefreshIndicator(
      backgroundColor: AppColors.pastel,
      color: AppColors.primary,
      onRefresh: () async => await controller.getHomeScreenUI(),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Scaffold(
            body: Center(
                child: CircularProgressIndicator(color: AppColors.primary)),
          );
        }
        var appBarData = controller.data["appBar"] ?? {};

        return Scaffold(
          backgroundColor: NvColor(controller.data["backgroundColor"]),
          appBar: AppBar(
            backgroundColor:
                NvColor(appBarData["backgroundColor"] ?? "primary"),
            title: TText(
              text: appBarData["title"] ?? AppStrings.appName,
              fontSize: AppSizes.headingSize,
              fontColor: NvColor(appBarData["textColor"] ?? "white"),
            ),
          ),
          body: ListView(
            padding: AppSizes.screenPadding,
            children: (controller.data['widgets'] as List)
                .map((widgetData) => buildWidget(widgetData))
                .toList(),
          ),
        );
      }),
    );
  }

  Widget buildWidget(Map<String, dynamic> widgetData) {
    switch (widgetData['type']) {
      case 'grid':
        var items = widgetData['items'] as List;
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widgetData['crossAxisCount'] ?? 2,
            mainAxisExtent: widgetData['mainAxisExtent']?.toDouble() ?? 150,
            mainAxisSpacing: widgetData['spacing']?.toDouble() ?? 15,
            crossAxisSpacing: widgetData['spacing']?.toDouble() ?? 15,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) => buildWidget(items[index]),
        );

      case 'container':
        return ShadowedContainer(
          onTap: () => Get.toNamed(widgetData["screen"]),
          padding: AppSizes.defaultPadding,
          backgroundColor: NvColor(widgetData["backgroundColor"] ?? "pastle"),
          shadowBlur: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TText(
                text: widgetData["title"] ?? "",
                fontWeight: AppSizes.wBold,
                fontColor: NvColor(widgetData["textColor"] ?? "primary"),
              ),
              SizedBox(height: AppSizes.smallHeight),
              ImageWidget(
                image: widgetData["image"] ?? AppImages.App_Logo,
                height: 6.5.h,
              )
            ],
          ),
        );

      default:
        return SizedBox.shrink();
    }
  }
}

/*class HomeScreen extends StatelessWidget {
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
}*/
