import 'package:get/get.dart';

import '../../../../Database/Ui_Services.dart';
import '../../../../Database/User_State_Listner.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.put(UserStateListenerService());
    getHomeScreenUI();
  }

  RxMap<String, dynamic> data = RxMap<String, dynamic>();
  RxBool isLoading = false.obs;

  Future<void> getHomeScreenUI() async {
    isLoading.value = true;
    data.value = await UIServices.getHomeScreen();
    isLoading.value = false;
  }

  // List homeList = [
  //   {
  //     "title": "Working Car",
  //     "image": AppImages.Working_Car,
  //     "screen": AppRoutes.WORKING_VEHICLE,
  //   },
  //   {
  //     "title": "Find Car",
  //     "image": AppImages.Find_Car,
  //     "screen": AppRoutes.FIND_VEHICLE,
  //   },
  //   {
  //     "title": "Add Car",
  //     "image": AppImages.Add_Car,
  //     "screen": AppRoutes.ADD_VEHICLE,
  //   },
  //   {
  //     "title": "Revenue",
  //     "image": AppImages.Revenue,
  //     "screen": () {},
  //   },
  // ];
}
