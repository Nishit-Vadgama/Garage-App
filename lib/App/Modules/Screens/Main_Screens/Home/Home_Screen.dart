import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Colors.dart';
import '../../../../../Config/App_Configs/App_Images.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/Config_Widgets/Image_Widget.dart';
import '../../../../../Config/Config_Widgets/Shadowed_Container.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import '../../../../AppHelper/App_Master_Data.dart';
import '../../../../Database/Collection_Service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CollectionService.UICollection.doc("home_screen").snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;
        var appBarData = data["appBar"] ?? {};

        return FutureBuilder<Color>(
          future: AppMasterData.fetchFirestoreColor(data["backgroundColor"]),
          builder: (context, colorSnapshot) {
            Color backgroundColor = colorSnapshot.data ?? AppColors.greyColor;

            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                // backgroundColor: appBarData["backgroundColor"] != null
                //     ? AppMasterData.hexToColor(appBarData["backgroundColor"])
                //     : AppColors.primaryColor,
                title: TText(
                  text: appBarData["title"] ?? "Dynamic Screen",
                  // fontColor: appBarData["textColor"] != null
                  //     ? AppMasterData.hexToColor(appBarData["textColor"])
                  //     : AppColors.whiteColor,
                  fontSize: AppSizes.headingSize,
                ),
              ),
              body: ListView(
                padding: AppSizes.screenPadding,
                children: (data['widgets'] as List)
                    .map((widgetData) => buildWidget(widgetData))
                    .toList(),
              ),
            );
          },
        );
      },
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
          // backgroundColor: widgetData["backgroundColor"] != null
          //     ? AppMasterData.hexToColor(widgetData["backgroundColor"])
          //     : AppColors.primaryPastelColor,
          backgroundColor: AppColors.primaryPastelColor,
          shadowBlur: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TText(
                text: widgetData["title"] ?? "",
                fontWeight: AppSizes.wBold,
                fontColor: AppColors.primaryColor,
                // fontColor: widgetData["textColor"] != null
                //     ? AppMasterData.hexToColor(widgetData["textColor"])
                //     : AppColors.primaryColor,
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

// class AppMasterData {
//   static final Map<String, Color> _colorCache = {};
//
//   /// Converts hex color string to Color object
//   static Color hexToColor(String hex) {
//     if (hex.isEmpty) return AppColors.whiteColor;
//     hex = hex.replaceAll("#", "");
//     if (hex.length == 6) {
//       hex = "FF$hex";
//     }
//     return Color(int.parse(hex, radix: 16));
//   }
//
//   /// Fetches color from Firestore and caches it
//   static Future<Color> fetchFirestoreColor(String docPath) async {
//     if (_colorCache.containsKey(docPath)) {
//       return _colorCache[docPath]!;
//     }
//
//     var docSnapshot = await FirebaseFirestore.instance.doc(docPath).get();
//     String colorCode = docSnapshot.data()?["code"] ?? "#FFFFFF";
//     Color color = hexToColor(colorCode);
//
//     _colorCache[docPath] = color; // Cache the color
//     return color;
//   }
// }

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
