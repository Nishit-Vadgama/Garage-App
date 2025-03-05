import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Modules/Screens/Auth/Login/Login_Screen.dart';
import '../Modules/Screens/Auth/Splash/Splash_Screen.dart';
import '../Modules/Screens/Main_Screens/Add_Car/Add_Car_Screen.dart';
import '../Modules/Screens/Main_Screens/Find_Car/Find_Car_Screen.dart';
import '../Modules/Screens/Main_Screens/Home/Home_Screen.dart';
import '../Modules/Screens/Main_Screens/Working_Car/Working_Car_Screen.dart';

class AppRoutes {
  /////////// Route Names ///////////
  static const String INITIAL = "/splash";
  static const String LOGIN = "/login";
  static const String HOME = "/home";
  static const String ADD_CAR = "/add_car";
  static const String WORKING_CAR = "/working_car";
  static const String FIND_CAR = "/find_car";

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
      name: WORKING_CAR,
      page: () => WorkingCarScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: ADD_CAR,
      page: () => AddCarScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: FIND_CAR,
      page: () => FindCarScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.easeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
