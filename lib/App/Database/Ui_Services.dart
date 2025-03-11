import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import 'Collection_Service.dart';

class UIServices {
  static final UIServices _instance = UIServices._internal();
  UIServices._internal();
  factory UIServices() => _instance;

  static final db = FirebaseFirestore.instance;
  static final Logger logger = Logger();

  //GET HOME SCREEN
  static Future<Map<String, dynamic>> getHomeScreen() async {
    try {
      DocumentSnapshot snapshot =
          await CollectionService.UICollection.doc("Home_Screen").get();
      if (snapshot.exists) {
        // print(jsonEncode(snapshot.data()));
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return {};
      }
    } catch (e) {
      logger.e("Error While Get Home Screen --> $e");
      return {};
    }
  }
}
