import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nv/App/Database/Collection_Service.dart';
import 'package:nv/App/Model/NvColors_Model.dart';

import '../../Config/App_Configs/App_Colors.dart';

class AppMasterData {
  // Convert Date To String Format (25-12-2025)
  static String dateToString(DateTime date) =>
      DateFormat('dd-MM-yyyy').format(date);

  // Convert String To Date Format
  static DateTime stringToDate(String date) =>
      DateFormat("dd-MM-yyyy").parse(date);

  /// Converts Firestore Timestamp to formatted date string (dd-MM-yyyy)
  static String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  /// Converts a formatted date string (dd-MM-yyyy) to Firestore Timestamp
  static Timestamp parseDateString(String dateString) {
    DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);
    return Timestamp.fromDate(date);
  }

  static Color hexToColor(String hex) {
    if (hex.isEmpty) return AppColors.white;
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF$hex";
    }
    return Color(int.parse(hex, radix: 16));
  }

  /// Fetch color from Firestore and update UI
  static Future<Color> fetchFirestoreColor(
      DocumentReference<Map<String, dynamic>> docRef) async {
    var snapshot = await docRef.get();
    String hexCode = snapshot.data()?["code"] ?? "#FFFFFF";
    Color finalColor = hexToColor(hexCode);
    return finalColor;
  }

  static Future<void> getAndSetConfigFromFirestore() async {
    var AllColors =
        await CollectionService.ConfigCollection.doc("All_Colors").get();

    FColors nvColors = FColors.fromJson(AllColors.data() ?? {});

    AppColors.white = hexToColor(nvColors.white!);
    AppColors.primary = hexToColor(nvColors.primary!);
    AppColors.pastel = hexToColor(nvColors.pastle!);
    AppColors.black = hexToColor(nvColors.black!);
    AppColors.text = hexToColor(nvColors.text!);
    AppColors.green = hexToColor(nvColors.green!);
    AppColors.grey = hexToColor(nvColors.grey!);
    AppColors.red = hexToColor(nvColors.red!);
    AppColors.shadow = hexToColor(nvColors.shadow!);
  }
}
