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
  final Service service;
  AddEditServiceController({required this.service});

  final formKey = GlobalKey<FormState>();
  RxList<Work> works = <Work>[].obs;
  TextEditingController problemController = TextEditingController();
  String serviceId = "";
  String vehicleId = "";
  RxBool isServiceDone = false.obs;
  Timestamp startDate = Timestamp.now();
  Timestamp? endDate;
  RxInt total = 0.obs;
  RxInt servicesTotal = 0.obs;
  RxInt itemsTotal = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (service.serviceId != null) setServiceData();
    vehicleId = service.vehicleId!;
  }

  setServiceData() {
    serviceId = service.serviceId.toString();
    problemController.text = service.problems.toString();
    isServiceDone.value = service.isDone!;
    works.value = service.work ?? [];
    startDate = service.startDate!;
    endDate = service.endDate;
    total.value = service.total!;
    servicesTotal.value = service.servicesTotal!;
    itemsTotal.value = service.itemsTotal!;
    vehicleId = service.vehicleId!;
    calculateTotal();
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
        endDate: isServiceDone.value ? (endDate ?? Timestamp.now()) : null,
        work: works,
        total: total.value,
        servicesTotal: servicesTotal.value,
        itemsTotal: itemsTotal.value,
        vehicleId: vehicleId,
      );

      if (isServiceDone.value && works.isEmpty) {
        return App_Snackbar(
            type: false, msg: "Please Add Works For This Service");
      }

      bool isSuccess =
          await DatabaseServices.addOrUpdateVehicleService(service: service);
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
    calculateTotal();
    works.refresh();
  }

  removeWork(int index) {
    works.removeAt(index);
    calculateTotal();
    works.refresh();
  }

  calculateTotal() {
    total.value = works.fold<int>(
        0,
        (previousValue, element) =>
            previousValue +
            (element.itemCost ?? 0) +
            (element.serviceCost ?? 0));

    servicesTotal.value = works.fold<int>(0,
        (previousValue, element) => previousValue + (element.serviceCost ?? 0));

    itemsTotal.value = works.fold<int>(
        0, (previousValue, element) => previousValue + (element.itemCost ?? 0));
  }
}
