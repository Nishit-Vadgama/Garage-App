import 'package:get/get.dart';

import '../../../../Database/Database_Services.dart';
import '../../../../Model/Vehicle_Model.dart';

class WorkingVehicleController extends GetxController {
  RxString searchQuery = "".obs;
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
    isLoading.value = false;
  }
}
