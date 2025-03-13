import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nv/App/Database/Database_Services.dart';
import 'package:nv/App/Model/Service_Model.dart';

class RevenueController extends GetxController {
  TextEditingController customMonthSearchController = TextEditingController();
  Rx<DateTime> fromDate = DateTime(
          DateTime.now().year, DateTime.now().month - 2, DateTime.now().day)
      .obs;

  Rx<DateTime> toDate = DateTime.now().obs;

  RxList<Service> allService = <Service>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllServices();
  }

  getAllServices() async {
    allService.value = await DatabaseServices.getAllServiceForGivenDate(
        fromDate.value, toDate.value);
  }
}
