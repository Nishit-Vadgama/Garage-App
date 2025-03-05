import 'package:cloud_firestore/cloud_firestore.dart';

class App_User {
  String? email;
  String? password;
  String? name;
  String? mobileNumber;
  bool? isActive;
  Timestamp? lastLogin;

  App_User({
    this.isActive,
    this.email,
    this.password,
    this.name,
    this.mobileNumber,
    this.lastLogin,
  });

  App_User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    lastLogin = json['lastLogin'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['mobileNumber'] = mobileNumber;
    data['name'] = name;
    data['lastLogin'] = lastLogin;
    data['isActive'] = isActive;
    return data;
  }
}
