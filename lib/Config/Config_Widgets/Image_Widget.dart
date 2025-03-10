import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../App_Configs/App_Colors.dart';
import '../App_Configs/App_Images.dart';
import '../App_Configs/App_Sizes.dart';
import 'Shadowed_Container.dart';

class ImageWidget extends StatelessWidget {
  final String image;
  final double? height, editIconsSize, width, loaderSize, shadowBlur;
  final double radius;
  final BoxFit? fit;
  final Color? shadowColor, backgroundColor, imageColor;
  final VoidCallback? onTap;
  final bool isShadow, isCircle;

  const ImageWidget({
    super.key,
    required this.image,
    required this.height,
    this.radius = 0,
    this.shadowColor,
    this.onTap,
    this.editIconsSize,
    this.fit,
    this.width,
    this.loaderSize,
    this.shadowBlur,
    this.isShadow = false,
    this.isCircle = false,
    this.backgroundColor,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ShadowedContainer(
          onTap: onTap,
          isBorder: false,
          isCircle: isCircle,
          backgroundColor: backgroundColor ?? Colors.transparent,
          shadowColor: isShadow ? shadowColor : Colors.transparent,
          shadowBlur: shadowBlur,
          borderRadius: isCircle ? 100 : radius,
          child: image.isNotEmpty
              ? image.contains("https")
                  ? NetworkImage_Widget(
                      image: image,
                      fit: fit ?? BoxFit.cover,
                      height: height,
                      width: width ?? height,
                      loaderSize: loaderSize,
                    )
                  : image.contains("assets")
                      ? Image.asset(
                          image,
                          fit: fit ?? BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          height: height,
                          width: width ?? height,
                          color: imageColor,
                        )
                      : FutureBuilder(
                          future: _loadFileImage(image),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return Image.file(
                                snapshot.data as File,
                                fit: fit ?? BoxFit.cover,
                                filterQuality: FilterQuality.none,
                                height: height,
                                width: width ?? height,
                              );
                            } else {
                              return Center(
                                child: LoadingAnimationWidget.discreteCircle(
                                  color: AppColors.primary,
                                  size: loaderSize ?? AppSizes.iconSize + 5,
                                ),
                              );
                            }
                          },
                        )
              : ShadowedContainer(
                  height: height,
                  width: width ?? height,
                  isCircle: isCircle,
                  backgroundColor: AppColors.white,
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      size: AppSizes.vBigIconSize + AppSizes.s16,
                      color: AppColors.primary,
                    ),
                  ),
                ),
        ),
        if (onTap != null)
          Positioned(
            bottom: 0,
            right: AppSizes.s14,
            child: Container(
              padding: EdgeInsets.all(AppSizes.s8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primary),
              child: Icon(
                Icons.edit,
                color: AppColors.white,
                size: editIconsSize ?? AppSizes.iconSize,
              ),
            ),
          )
      ],
    );
  }

  Future<File> _loadFileImage(String path) async => File(path);
}

class NetworkImage_Widget extends StatelessWidget {
  final String image;
  final double? height, width, loaderSize;
  final BoxFit? fit;

  const NetworkImage_Widget({
    super.key,
    required this.image,
    this.height,
    this.fit,
    this.width,
    this.loaderSize,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit ?? BoxFit.cover,
      imageUrl: image,
      height: height,
      width: width ?? height,
      placeholder: (context, url) => Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: AppColors.primary,
          size: loaderSize ?? AppSizes.iconSize + 5,
        ),
      ),
      errorWidget: (context, url, error) => const ImageWidget(
        image: AppImages.App_Logo,
        height: double.infinity,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
