import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Config/App_Configs/App_Strings.dart';
import '../../../../../Config/Config_Widgets/Snackbar.dart';
import '../../../../Database/Auth_Services.dart';
import '../../../../Routes/App_Routes.dart';

class Login_Controller extends GetxController {
  RxBool isShowPassword = false.obs;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  login() async {
    if (!loginKey.currentState!.validate()) {
      return App_Snackbar(type: false, msg: AppStrings.Enter_All_Details);
    } else {
      isLoading.value = true;
      bool isSuccess = await AuthServices.Login(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (isSuccess) Get.offAllNamed(AppRoutes.HOME);
      isLoading.value = false;
    }
  }
}
