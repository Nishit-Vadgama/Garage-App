import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Database/Database_Services.dart';
import '../../../../Model/Service_Model.dart';

class RevenueController extends GetxController {
  TextEditingController customMonthSearchController = TextEditingController();
  Rx<DateTime> fromDate = DateTime(
          DateTime.now().year, DateTime.now().month - 2, DateTime.now().day)
      .obs;
  Rx<DateTime> toDate = DateTime.now().obs;
  RxList<Service> allService = <Service>[].obs;
  RxBool isLoading = false.obs;
  RxInt total = 0.obs;
  RxInt servicesTotal = 0.obs;
  RxInt itemsTotal = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getAllServices();
  }

  getAllServices() async {
    isLoading.value = true;
    allService.value = await DatabaseServices.getAllServiceForGivenDate(
        fromDate.value, toDate.value);
    calculateTotal();
    isLoading.value = false;
  }

  calculateTotal() {
    total.value = allService.fold<int>(
        0, (previousValue, element) => previousValue + (element.total ?? 0));

    servicesTotal.value = allService.fold<int>(
        0,
        (previousValue, element) =>
            previousValue + (element.servicesTotal ?? 0));

    itemsTotal.value = allService.fold<int>(0,
        (previousValue, element) => previousValue + (element.itemsTotal ?? 0));
  }
}
