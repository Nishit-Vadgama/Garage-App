import 'package:get/get.dart';

import '../../../../../Config/Config_Widgets/Snackbar.dart';
import '../../../../Database/Database_Services.dart';
import '../../../../Model/Service_Model.dart';
import '../../../../Model/Vehicle_Model.dart';

class VehicleDetailController extends GetxController {
  final String vehicleId;
  Vehicle vehicle = Vehicle();
  RxBool isLoading = false.obs;
  RxBool serviceLoading = false.obs;
  RxList<Service> vehicleServices = <Service>[].obs;

  VehicleDetailController({required this.vehicleId});

  @override
  void onInit() {
    super.onInit();
    getVehicleById();
    getVehicleServices();
  }

  getVehicleById() async {
    isLoading.value = true;
    try {
      vehicle =
          await DatabaseServices.getVehicleByVehicleId(vehicleId: vehicleId);
    } catch (e) {
      App_Snackbar(type: false, msg: "Vehicle not found");
    } finally {
      isLoading.value = false;
    }
  }

  getVehicleServices() async {
    serviceLoading.value = true;
    try {
      vehicleServices.value =
          await DatabaseServices.getVehicleServices(vehicleId: vehicleId);
    } catch (e) {
      App_Snackbar(type: false, msg: "Services not found");
    }
    serviceLoading.value = false;
  }
}
