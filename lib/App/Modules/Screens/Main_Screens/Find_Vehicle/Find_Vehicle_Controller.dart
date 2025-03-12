import 'package:get/get.dart';
import 'package:nv/App/Database/Database_Services.dart';
import 'package:nv/App/Model/Vehicle_Model.dart';

class FindVehicleController extends GetxController {
  RxList<Vehicle> allVehicles = <Vehicle>[].obs;
  RxList<Vehicle> filteredVehicles = <Vehicle>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllVehicles();
  }

  getAllVehicles() async {
    isLoading.value = true;
    allVehicles.value = await DatabaseServices.getAllVehicles();
    filteredVehicles.value = allVehicles;
    isLoading.value = false;
  }

  void filterVehicleByName(String newText) {
    String formattedText =
        newText.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

    filteredVehicles.value = allVehicles.where((vehicle) {
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
