import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../AppHelper/App_Preference.dart';
import 'Collection_Service.dart';

class UserStateListenerService extends GetxController {
  Timer? _timer;
  String? _userId;

  @override
  void onInit() {
    super.onInit();
    _checkUserStatusOnAppStart();
  }

  /// Set the current user ID and start monitoring status
  void setUserId(String userId) {
    _userId = userId;
    _startUserStatusCheck();
  }

  /// Check user status when the app starts
  Future<void> _checkUserStatusOnAppStart() async {
    String userId = AppPreference.getCurrentUserEmail();

    if (userId.isNotEmpty) {
      _userId = userId;
      bool check = await _checkUserStatus();
      if (check) {
        _startUserStatusCheck();
      }
    } else {
      AppPreference.logout();
    }
  }

  /// Start periodic user status check
  void _startUserStatusCheck() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 2), (timer) async {
      await _checkUserStatus();
    });
  }

  /// Check user status from Firestore
  Future<bool> _checkUserStatus() async {
    if (_userId == null) false;

    try {
      DocumentSnapshot usersDocuments =
          await CollectionService.UserCollection.doc(_userId).get();

      if (usersDocuments.exists) {
        bool isActive = usersDocuments.get('isActive') ?? false;

        if (isActive == false) {
          print("User is inactive. Logging out...");
          AppPreference.logout();
          return false;
        } else {
          return true;
        }
      } else {
        print("User document not found. Logging out...");
        AppPreference.logout();
        return false;
      }
    } catch (e) {
      print('Error checking user status from Firestore: $e');
      return false;
    }
  }
}

/*class UserStateListenerService extends GetxController {
  final FirebaseAuth _auth = AuthServices.Auth;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    // Check user status when the app starts
    _checkUserStatusOnAppStart();

    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        AppPreference.LogOut();
        Get.offAll(const Login_Screen());
      } else {
        _startTokenRefresh(user);
      }
    });
  }

  // Check the logged-in user's status when the app starts
  Future<void> _checkUserStatusOnAppStart() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        // Reload the user to get the latest token
        await currentUser.reload();
        final idTokenResult = await currentUser.getIdTokenResult(true);

        // Check if the user's account is disabled
        if (idTokenResult.claims?['disabled'] == true) {
          await _auth.signOut();
          AppPreference.LogOut();
          Get.offAll(const Login_Screen());
        }
      } catch (e) {
        print('Error checking user status on app start: $e');
      }
    }
  }

  // Start periodic token refresh
  void _startTokenRefresh(User user) {
    _timer?.cancel();

    print("TOKEN REFRESH STARTED");

    _timer = Timer.periodic(const Duration(minutes: 2), (timer) async {
      try {
        await user.reload();
        final idTokenResult = await user.getIdTokenResult(true);
        if (idTokenResult.claims?['disabled'] == true) {
          await _auth.signOut();
          AppPreference.LogOut();
          Get.offAll(const Login_Screen());
        }
      } catch (e) {
        print('Error checking user status: $e');
      }
    });
  }
}*/
