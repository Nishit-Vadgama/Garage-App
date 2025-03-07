import 'package:cloud_firestore/cloud_firestore.dart';

import 'Work_Model.dart';

class Service {
  Timestamp? startDate;
  Timestamp? endDate;
  String? serviceId;
  String? problems;
  bool? isDone;
  List<Work>? work;

  Service({
    this.startDate,
    this.endDate,
    this.serviceId,
    this.problems,
    this.isDone,
    this.work,
  });

  Service.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
    serviceId = json['serviceId'];
    problems = json['problems'];
    isDone = json['isDone'];
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
    if (work != null) {
      data['work'] = work!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
