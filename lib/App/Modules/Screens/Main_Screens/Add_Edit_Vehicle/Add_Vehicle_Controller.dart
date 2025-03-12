import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Config/App_Configs/App_Strings.dart';
import '../../../../../Config/Config_Widgets/Snackbar.dart';
import '../../../../Database/Database_Services.dart';
import '../../../../Model/Vehicle_Model.dart';
import '../Vehicle_Detail/Vehicle_Detail_Controller.dart';

class AddVehicleController extends GetxController {
  final Vehicle? vehicle;
  AddVehicleController({this.vehicle});

  final addCarFromKey = GlobalKey<FormState>();
  String vehicleId = "";
  RxString vehicleImage = "".obs;
  TextEditingController vehicleNumberPlate = TextEditingController();
  TextEditingController vehicleModel = TextEditingController();
  TextEditingController vehicleOwnerName = TextEditingController();
  TextEditingController vehicleOwnerPhoneNumber = TextEditingController();
  RxBool isLoading = false.obs;
  Timestamp addedOn = Timestamp.now();
  bool inWorkShop = false;

  @override
  void onInit() {
    super.onInit();
    if (vehicle != null) setVehicle();
  }

  void setVehicle() {
    vehicleId = vehicle?.vehicleId ?? "";
    vehicleImage.value = vehicle?.vehicleImage ?? "";
    vehicleNumberPlate.text = vehicle?.numberPlate ?? "";
    vehicleModel.text = vehicle?.model ?? "";
    vehicleOwnerName.text = vehicle?.ownerName ?? "";
    vehicleOwnerPhoneNumber.text = vehicle?.ownerPhoneNumber ?? "";

    addedOn = vehicle?.addedOn ?? Timestamp.now();
  }

  void saveVehicle() async {
    if (addCarFromKey.currentState!.validate()) {
      if (vehicleImage.value.isEmpty) {
        App_Snackbar(type: false, msg: "Select Vehicle Image");
        return;
      }
      isLoading.value = true;
      try {
        Vehicle finalVehicle = Vehicle(
          vehicleId: vehicleId,
          vehicleImage: vehicleImage.value,
          ownerName: vehicleOwnerName.text.trim(),
          ownerPhoneNumber: vehicleOwnerPhoneNumber.text.trim(),
          numberPlate: vehicleNumberPlate.text.trim(),
          model: vehicleModel.text.trim(),
          addedOn: addedOn,
        );
        final isSuccess = vehicle != null
            ? await DatabaseServices.updateVehicle(vehicle: finalVehicle)
            : await DatabaseServices.addVehicle(vehicle: finalVehicle);
        if (isSuccess) {
          Get.back();
          App_Snackbar(
            type: true,
            msg: vehicle != null
                ? "Vehicle Updated Successfully"
                : "Vehicle Added Successfully",
          );
          if (vehicle != null) {
            Get.find<VehicleDetailController>().getVehicleById();
          }
        }
      } catch (error) {
        App_Snackbar(
            type: false,
            msg: "${AppStrings.somethingWentWrong}. Please try again later.");
      }
      isLoading.value = false;
    } else {
      App_Snackbar(type: false, msg: AppStrings.Enter_All_Details);
    }
  }
}
