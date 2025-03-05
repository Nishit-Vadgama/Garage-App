import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFunctions {
  static final AppFunctions _instance = AppFunctions._internal();
  AppFunctions._internal();
  factory AppFunctions() => _instance;

  static void hideKeyboard(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScope.of(context).unfocus();
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> sendEmail(String emailUrl) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: emailUrl,
    );
    await launchUrl(launchUri);
  }
}
