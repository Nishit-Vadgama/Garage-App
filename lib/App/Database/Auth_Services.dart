import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Config/App_Configs/App_Strings.dart';
import '../../Config/Config_Widgets/Snackbar.dart';
import '../AppHelper/App_Preference.dart';
import '../Model/App_User_Model.dart';
import 'Collection_Service.dart';

class AuthServices {
  static final AuthServices _instance = AuthServices._internal();
  AuthServices._internal();
  factory AuthServices() => _instance;

  static final Firestore = FirebaseFirestore.instance;
  // ------------- EMAIL & PASSWORD Login ------------- //
  static Future<bool> Login({
    required String email,
    required String password,
  }) async {
    try {
      final userDoc = await CollectionService.UserCollection.doc(email).get();
      // print("EMAIL --> ${userDoc.data()!["email"]}");
      // print("PASSWORD --> ${userDoc.data()!["password"]}");
      // print("ISACTIVE --> ${userDoc.data()!["isActive"]}");

      if (userDoc.exists) {
        if ((userDoc.data()!["password"] == password) &&
            (userDoc.data()!["isActive"] == true)) {
          App_Snackbar(type: true, msg: "Successfully Logged In");
          AppPreference.setCurrentUserEmail(email);
          AppPreference.setLogined();
          return true;
        } else {
          App_Snackbar(type: false, msg: "Invalid Credentials");
          return false;
        }
      } else {
        App_Snackbar(type: false, msg: "User Not Found");
        return false;
      }
    } catch (error) {
      App_Snackbar(type: false, msg: AppStrings.somethingWentWrong);
      return false;
    }
  }

  static Future<bool> Register({
    required String email,
    required String password,
    required String mobileNumber,
    required String name,
  }) async {
    try {
      App_User app_user = App_User(
        name: name,
        email: email,
        mobileNumber: mobileNumber,
        isActive: true,
        lastLogin: Timestamp.now(),
        password: password,
      );
      await AddUserToDatabase(appUser: app_user);
      App_Snackbar(type: true, msg: "Successfully Logged In");
      return true;
    } catch (error) {
      App_Snackbar(type: false, msg: AppStrings.somethingWentWrong);
      return false;
    }
  }

  static Future AddUserToDatabase({required App_User appUser}) async {
    try {
      await CollectionService.UserCollection.doc(appUser.email)
          .set(appUser.toJson());
    } catch (error) {
      App_Snackbar(type: false, msg: AppStrings.somethingWentWrong);
    }
  }
}
