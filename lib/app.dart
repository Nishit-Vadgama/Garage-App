import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nv/App/Routes/App_Routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'Config/App_Configs/App_Strings.dart';
import 'Config/App_Configs/App_Theme.dart';
import 'Config/App_Configs/Network_Manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ResponsiveSizer(
        builder: (context, orientation, screenType) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: AppTheme.appTheme,
          onInit: () {
            Get.put(Network_Controller(), permanent: true);
          },
          getPages: AppRoutes.pages,
          initialRoute: AppRoutes.INITIAL,
        ),
      );
}
