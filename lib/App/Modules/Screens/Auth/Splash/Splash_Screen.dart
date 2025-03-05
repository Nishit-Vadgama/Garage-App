import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:nv/App/Routes/App_Routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Images.dart';
import '../../../../../Config/Config_Widgets/Image_Widget.dart';
import '../../../../AppHelper/App_Preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateTo();
  }

  navigateTo() {
    final bool isLogined = AppPreference.isLogined();
    Future.delayed(const Duration(seconds: 3),
        () => Get.offAllNamed(isLogined ? AppRoutes.HOME : AppRoutes.LOGIN));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ImageWidget(
          image: AppImages.App_Logo,
          height: 20.h,
          fit: BoxFit.scaleDown,
        )
            .animate()
            .fadeIn(curve: Curves.ease, duration: Duration(seconds: 1))
            .moveY(begin: 3.h, end: 0),
      ),
    );
  }
}
