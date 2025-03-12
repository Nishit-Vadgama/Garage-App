import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../App_Configs/App_Colors.dart';
import '../App_Configs/App_Sizes.dart';

class FullScreenImageScreen extends StatelessWidget {
  final String image;
  const FullScreenImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Hero(
            tag: image,
            child: PhotoView(
              filterQuality: FilterQuality.high,
              loadingBuilder: (context, event) => Center(
                  child: CircularProgressIndicator(color: AppColors.primary)),
              imageProvider: image.contains("https")
                  ? NetworkImage(image)
                  : FileImage(File(image)),
            ),
          ),
          Positioned(
            top: 6.h,
            left: 5.w,
            child: IconButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.white)),
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: AppColors.primary,
                size: AppSizes.bigIconSize,
              ),
            ),
          )
        ],
      ),
    );
  }
}
