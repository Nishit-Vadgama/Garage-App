import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';

import 'App_Preference.dart';

class CountryController extends GetxController {
  Rx<Country> selectedCountry = AppPreference.getCountry().obs;

  void updateCountry(Country newCountry) {
    selectedCountry.value = newCountry;
    AppPreference.setCountry(selectedCountry.value);
    update();
  }
}
