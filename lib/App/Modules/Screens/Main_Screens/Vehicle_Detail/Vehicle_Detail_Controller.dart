import 'package:get/get.dart';
import 'package:nv/App/Database/Database_Services.dart';
import 'package:nv/App/Model/Vehicle_Model.dart';
import 'package:nv/Config/Config_Widgets/Snackbar.dart';

class VehicleDetailController extends GetxController {
  final String vehicleId;
  Vehicle vehicle = Vehicle();
  RxBool isLoading = false.obs;

  VehicleDetailController({required this.vehicleId});

  @override
  void onInit() {
    super.onInit();
    getVehicleById(vehicleId);
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
}
