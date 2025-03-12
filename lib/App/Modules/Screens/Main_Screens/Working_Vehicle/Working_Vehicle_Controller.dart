import 'package:get/get.dart';

import '../../../../Database/Database_Services.dart';
import '../../../../Model/Vehicle_Model.dart';

class WorkingVehicleController extends GetxController {
  RxList<Vehicle> workingVehicles = <Vehicle>[].obs;
  RxList<Vehicle> filteredVehicles = <Vehicle>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllWorkingVehicles();
  }

  getAllWorkingVehicles() async {
    isLoading.value = true;
    workingVehicles.value = await DatabaseServices.getWorkingVehicles();
    filteredVehicles.value = workingVehicles;
    isLoading.value = false;
  }

  void filterVehicleByName(String newText) {
    String formattedText =
        newText.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

    filteredVehicles.value = workingVehicles.where((vehicle) {
      String ownerName = vehicle.ownerName.toString().toLowerCase().trim();

      String formattedPlate = vehicle.numberPlate
          .toString()
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9]'), '');

      return ownerName.contains(formattedText) ||
          formattedPlate.contains(formattedText);
    }).toList();

    filteredVehicles.refresh();
  }
}
