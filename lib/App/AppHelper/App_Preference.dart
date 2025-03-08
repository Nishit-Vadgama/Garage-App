import 'package:country_picker/country_picker.dart';
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

  static Country defaultCountry = Country(
    countryCode: "IN",
    name: "India",
    phoneCode: '91',
    e164Sc: 23232,
    geographic: true,
    level: 1,
    example: '9499538851',
    displayName: '',
    displayNameNoCountryCode: '',
    e164Key: '',
  );

  static setDefaultCountry() {
    setCountry(getCountry());
  }

  static String getCurrentUserEmail() =>
      AppStorage.read(AppStrings.currentUserEmail) ?? "";

  static setCurrentUserEmail(String appUserEmail) =>
      AppStorage.write(AppStrings.currentUserEmail, appUserEmail);

  static setCountry(Country country) =>
      AppStorage.write(AppStrings.currentCountry, country.toJson());

  static Country getCountry() {
    Map<String, dynamic> json =
        AppStorage.read(AppStrings.currentCountry) ?? defaultCountry.toJson();
    return Country.from(json: json);
  }
}
