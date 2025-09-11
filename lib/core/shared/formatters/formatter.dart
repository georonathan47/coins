import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime date) {
    return DateFormat('dd-MMM-yyyy')
        .format(date); // Customize the date format as needed
  }

  /// Formats date into year,month,day and time eg: September 4, 2021 11:00 am
  static String formatDateOfBirth(DateTime date) {
    try {
      final formatter = DateFormat.yMMMMd();
      return formatter.format(date);
    } on FormatException {
      return '❌ Invalid Date';
    }
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_GH', symbol: 'GHS')
        .format(amount); // Customize the currency locale and symbol as needed
  }

  static String formatDollar(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: 'USD')
        .format(amount); // Customize the currency locale and symbol as needed
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 10-digit US phone number format: (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    // Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
  }

   static String formatDateString(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy • HH:mm').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
