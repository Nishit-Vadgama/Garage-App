import 'package:intl/intl.dart';

class AppMasterData {
  // Convert Date To String Format (25-12-2025)
  static String dateToString(DateTime date) =>
      DateFormat('dd-MM-yyyy').format(date);

  // Convert String To Date Format
  static DateTime stringToDate(String date) =>
      DateFormat("dd-MM-yyyy").parse(date);
}
