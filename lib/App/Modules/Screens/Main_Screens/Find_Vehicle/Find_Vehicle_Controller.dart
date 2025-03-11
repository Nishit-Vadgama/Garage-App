import 'package:get/get.dart';
import 'package:nv/App/Database/Database_Services.dart';
import 'package:nv/App/Model/Vehicle_Model.dart';

class FindVehicleController extends GetxController {
  RxString searchQuery = ''.obs;
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
    isLoading.value = false;
  }
}
