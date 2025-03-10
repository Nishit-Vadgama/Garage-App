import 'package:get/get.dart';
import 'package:nv/App/Database/Database_Services.dart';
import 'package:nv/App/Model/Service_Model.dart';
import 'package:nv/App/Model/Vehicle_Model.dart';
import 'package:nv/Config/Config_Widgets/Snackbar.dart';

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
    getVehicleById(vehicleId);
    getVehicleServices();
  }

  getVehicleById(vehicleId) async {
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
