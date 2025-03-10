import 'package:get/get.dart';

import '../../Config/App_Configs/App_Storage.dart';
import '../../Config/App_Configs/App_Strings.dart';
import '../Modules/Screens/Auth/Login/Login_Screen.dart';

class AppPreference {
  static void setAccessToken(String accessToken) =>
      AppStorage.write(AppStrings.accessToken, accessToken);

  static String getAccessToken() =>
      AppStorage.read(AppStrings.accessToken) ?? "";

  static bool isLogined() => AppStorage.read(AppStrings.isLogin) ?? false;

  static void setLogined() => AppStorage.write(AppStrings.isLogin, true);

  static void logout() {
    AppStorage.App_Storage.erase();
    Get.offAll(() => const LoginScreen());
  }

  static String getCurrentUserEmail() =>
      AppStorage.read(AppStrings.currentUserEmail) ?? "";

  static setCurrentUserEmail(String appUserEmail) =>
      AppStorage.write(AppStrings.currentUserEmail, appUserEmail);
}
