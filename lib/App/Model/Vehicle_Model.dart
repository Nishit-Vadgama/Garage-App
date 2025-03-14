import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  String? vehicleId;
  String? vehicleImage;
  String? numberPlate;
  String? model;
  String? ownerName;
  String? ownerPhoneNumber;
  Timestamp? addedOn;

  Vehicle({
    this.vehicleId,
    this.vehicleImage,
    this.numberPlate,
    this.model,
    this.ownerName,
    this.ownerPhoneNumber,
    this.addedOn,
  });

  Vehicle.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicleId'];
    vehicleImage = json['vehicleImage'];
    numberPlate = json['numberPlate'];
    addedOn = json['addedOn'];
    model = json['model'];
    ownerName = json['ownerName'];
    ownerPhoneNumber = json['ownerPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicleId'] = vehicleId;
    data['vehicleImage'] = vehicleImage;
    data['numberPlate'] = numberPlate;
    data['addedOn'] = addedOn;
    data['model'] = model;
    data['ownerName'] = ownerName;
    data['ownerPhoneNumber'] = ownerPhoneNumber;

    return data;
  }
}
