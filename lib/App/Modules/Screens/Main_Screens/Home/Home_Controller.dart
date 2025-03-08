import 'package:get/get.dart';

import '../../../../../Config/App_Configs/App_Images.dart';
import '../../../../Database/User_State_Listner.dart';
import '../../../../Routes/App_Routes.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.put(UserStateListenerService());
  }

  List homeList = [
    {
      "title": "Working Car",
      "image": AppImages.Working_Car,
      "screen": AppRoutes.WORKING_VEHICLE,
    },
    {
      "title": "Find Car",
      "image": AppImages.Find_Car,
      "screen": AppRoutes.FIND_VEHICLE,
    },
    {
      "title": "Add Car",
      "image": AppImages.Add_Car,
      "screen": AppRoutes.ADD_VEHICLE,
    },
    {
      "title": "Revenue",
      "image": AppImages.Revenue,
      "screen": () {},
    },
  ];
}
