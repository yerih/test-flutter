


import 'package:intl/intl.dart';

extension StringExtension on String {
  String formatDateTime() {
    try {
      // Parse the string to a DateTime object
      DateTime dateTime = DateTime.parse(this);

      // Format the DateTime object to the desired format
      String formattedDate = DateFormat('h:mm:ss a,  dd/MM/yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      // Handle parsing errors, e.g., return an error message or a default value
      print("Error parsing or formatting date: $e");
      return "Invalid Date"; // Or some other default/error indicator
    }
  }
}

