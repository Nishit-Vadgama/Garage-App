import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nv/Config/App_Configs/App_Colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../Config/App_Configs/App_Images.dart';
import '../../../../../Config/App_Configs/App_Sizes.dart';
import '../../../../../Config/App_Configs/App_Strings.dart';
import '../../../../../Config/Config_Widgets/App_Button.dart';
import '../../../../../Config/Config_Widgets/Image_Widget.dart';
import '../../../../../Config/Config_Widgets/Text_Field.dart';
import '../../../../../Config/Config_Widgets/Text_Widget.dart';
import 'Login_Controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Login_Controller());

    return Scaffold(
      backgroundColor: AppColors.greyColor,
      body: Obx(() => Form(
            key: controller.loginKey,
            child: ListView(
              padding: AppSizes.screenPadding,
              children: [
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.center,
                  child: ImageWidget(
                    image: AppImages.App_Logo,
                    fit: BoxFit.scaleDown,
                    height: 18.h,
                  ),
                ),
                SizedBox(height: AppSizes.bigHeight + AppSizes.s14),
                TText(
                  text: "Login",
                  fontWeight: AppSizes.wBold,
                  fontSize: AppSizes.headingSize + AppSizes.f10,
                  fontCentered: true,
                ),
                SizedBox(height: AppSizes.mediumHeight),
                ShadowTextField(
                  controller: controller.emailController,
                  label: AppStrings.Email,
                  isCapitalWords: false,
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    size: AppSizes.bigIconSize,
                  ),
                ),
                ShadowTextField(
                  obscure: controller.isShowPassword.value ? false : true,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: AppSizes.bigIconSize,
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value.toString().length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    return null;
                  },
                  controller: controller.passwordController,
                  label: AppStrings.Password,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isShowPassword.value =
                          !controller.isShowPassword.value;
                    },
                    icon: Icon(
                      controller.isShowPassword.value
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      size: AppSizes.iconSize,
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.mediumHeight),
                Obx(
                  () => AppButton(
                    isLoading: controller.isLoading.value,
                    onPress: controller.login,
                    text: AppStrings.Login,
                  ),
                ),
              ],
            ).animate().fadeIn().moveY(
                  begin: -3.h,
                  end: 0,
                  delay: Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeIn,
                ),
          )),
    );
  }
}
