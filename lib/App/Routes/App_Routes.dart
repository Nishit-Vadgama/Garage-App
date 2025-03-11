import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Modules/Screens/Auth/Login/Login_Screen.dart';
import '../Modules/Screens/Auth/Splash/Splash_Screen.dart';
import '../Modules/Screens/Main_Screens/Add_Edit_Service/Add_Edit_Service_Screen.dart';
import '../Modules/Screens/Main_Screens/Add_Edit_Vehicle/Add_Vehicle_Screen.dart';
import '../Modules/Screens/Main_Screens/Find_Vehicle/Find_Vehicle_Screen.dart';
import '../Modules/Screens/Main_Screens/Home/Home_Screen.dart';
import '../Modules/Screens/Main_Screens/Vehicle_Detail/Vehicle_Detail_Screen.dart';
import '../Modules/Screens/Main_Screens/Working_Vehicle/Working_Vehicle_Screen.dart';

class AppRoutes {
  /////////// Route Names ///////////
  static const String INITIAL = "/splash";
  static const String LOGIN = "/login";
  static const String HOME = "/home";
  static const String ADD_VEHICLE = "/add_vehicle";
  static const String WORKING_VEHICLE = "/working_vehicle";
  static const String FIND_VEHICLE = "/find_vehicle";
  static const String VEHICLE_DETAIL = "/vehicle_detail";
  static const String ADD_SERVICE = "/add_service";

  /////////// App Routes ///////////
  static final pages = [
    GetPage(
      name: INITIAL,
      page: () => SplashScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 800),
    ),
    GetPage(
      name: LOGIN,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 800),
    ),
    GetPage(
      name: HOME,
      page: () => HomeScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 800),
    ),
    GetPage(
      name: WORKING_VEHICLE,
      page: () => WorkingVehicleScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: ADD_VEHICLE,
      page: () => AddVehicleScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: FIND_VEHICLE,
      page: () => FindVehicleScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: VEHICLE_DETAIL,
      page: () => VehicleDetailScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: ADD_SERVICE,
      page: () => AddEditServiceScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
