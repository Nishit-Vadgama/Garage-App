import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nv/App/Database/Database_Services.dart';
import 'package:nv/App/Model/Vehicle_Model.dart';
import 'package:nv/Config/App_Configs/App_Strings.dart';
import 'package:nv/Config/Config_Widgets/Snackbar.dart';

class AddCarController extends GetxController {
  final addCarFromKey = GlobalKey<FormState>();
  String vehicleId = "";
  RxString vehicleImage = "".obs;
  TextEditingController vehicleNumberPlate = TextEditingController();
  TextEditingController vehicleModel = TextEditingController();
  TextEditingController vehicleOwnerName = TextEditingController();
  TextEditingController vehicleOwnerPhoneNumber = TextEditingController();
  TextEditingController vehicleOwnerAddress = TextEditingController();
  RxBool isLoading = false.obs;

  void saveCar() async {
    if (addCarFromKey.currentState!.validate()) {
      if (vehicleImage.value.isEmpty) {
        App_Snackbar(type: false, msg: "Select Vehicle Image");
        return;
      }
      isLoading.value = true;
      try {
        Vehicle vehicle = Vehicle(
          vehicleId: vehicleId,
          vehicleImage: vehicleImage.value,
          ownerName: vehicleOwnerName.text.trim(),
          ownerPhoneNumber: vehicleOwnerPhoneNumber.text.trim(),
          ownerAddress: vehicleOwnerAddress.text.trim(),
          numberPlate: vehicleNumberPlate.text.trim(),
          model: vehicleModel.text.trim(),
          inWorkShop: false,
        );
        final isSuccess = await DatabaseServices.addVehicle(vehicle: vehicle);
        if (isSuccess) {
          Get.back();
          App_Snackbar(type: true, msg: "Vehicle Added Successfully");
        }
      } catch (error) {
        App_Snackbar(
            type: false, msg: "Failed to add vehicle. Please try again later.");
      }
      isLoading.value = false;
    } else {
      App_Snackbar(type: false, msg: AppStrings.Enter_All_Details);
    }
  }
}
