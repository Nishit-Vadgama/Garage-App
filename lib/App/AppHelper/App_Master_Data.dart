import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
}
