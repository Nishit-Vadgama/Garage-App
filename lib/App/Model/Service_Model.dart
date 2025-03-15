import 'package:cloud_firestore/cloud_firestore.dart';

import 'Work_Model.dart';

class Service {
  Timestamp? startDate;
  Timestamp? endDate;
  String? serviceId;
  String? vehicleId;
  String? problems;
  int? total;
  int? servicesTotal;
  int? itemsTotal;
  bool? isDone;
  List<Work>? work;

  Service({
    this.startDate,
    this.endDate,
    this.serviceId,
    this.problems,
    this.isDone,
    this.work,
    this.total,
    this.itemsTotal,
    this.vehicleId,
    this.servicesTotal,
  });

  Service.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
    serviceId = json['serviceId'];
    problems = json['problems'];
    isDone = json['isDone'];
    total = json['total'];
    itemsTotal = json['itemsTotal'];
    vehicleId = json['vehicleId'];
    servicesTotal = json['servicesTotal'];
    if (json['work'] != null) {
      work = <Work>[];
      json['work'].forEach((v) {
        work!.add(Work.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['serviceId'] = serviceId;
    data['problems'] = problems;
    data['isDone'] = isDone;
    data['total'] = total;
    data['itemsTotal'] = itemsTotal;
    data['servicesTotal'] = servicesTotal;
    data['vehicleId'] = vehicleId;
    if (work != null) {
      data['work'] = work!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
