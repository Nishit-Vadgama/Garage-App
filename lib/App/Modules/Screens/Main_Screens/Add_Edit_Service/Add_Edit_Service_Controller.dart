import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Config/App_Configs/App_Strings.dart';
import '../../../../../Config/Config_Widgets/Snackbar.dart';
import '../../../../Database/Database_Services.dart';
import '../../../../Model/Service_Model.dart';
import '../../../../Model/Work_Model.dart';
import '../Vehicle_Detail/Vehicle_Detail_Controller.dart';

class AddEditServiceController extends GetxController {
  final Service? service;
  final String? vehicleId;
  AddEditServiceController({this.vehicleId, this.service});

  final formKey = GlobalKey<FormState>();
  RxList<Work> works = <Work>[Work()].obs;
  TextEditingController problemController = TextEditingController();
  String serviceId = "";
  RxBool isServiceDone = false.obs;
  Timestamp startDate = Timestamp.now();
  Timestamp endDate = Timestamp.now();

  @override
  void onInit() {
    super.onInit();
    if (service != null) setServiceData();
  }

  setServiceData() {
    serviceId = service!.serviceId.toString();
    problemController.text = service!.problems.toString();
    isServiceDone.value = service!.isDone!;
    works.value = service!.work ?? [];
    startDate = service!.startDate!;
    endDate = service!.endDate!;
  }

  saveService() async {
    if (!formKey.currentState!.validate()) {
      return App_Snackbar(type: false, msg: AppStrings.Enter_All_Details);
    } else {
      Service service = Service(
        serviceId: serviceId,
        problems: problemController.text.trim(),
        isDone: isServiceDone.value,
        startDate: startDate,
        endDate: endDate,
        work: works,
      );

      bool isSuccess = await DatabaseServices.addOrUpdateVehicleService(
        vehicleId: vehicleId.toString(),
        service: service,
      );
      if (isSuccess) {
        Get.find<VehicleDetailController>().getVehicleServices();
        Get.back();
        App_Snackbar(type: true, msg: "Service Saved Successfully");
      } else {
        App_Snackbar(type: false, msg: AppStrings.somethingWentWrong);
      }
    }
  }

  addWork() {
    works.add(Work(workTitle: "", workDescription: ""));
    works.refresh();
  }

  removeWork(int index) {
    works.removeAt(index);
    works.refresh();
  }
}
