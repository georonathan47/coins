import 'package:intl/intl.dart';

/// Format Currency
class CurrencyFormatter {
  /// Finds local currency symbol
  static String _ghanaSymbol() {
    // Probably find currency from local
    return 'GH₵';
  }

  /// returns amount in thousands or hundreds
  static String ghana(double amount) {
    final formatter = NumberFormat('${_ghanaSymbol()}#,##0.00', 'en_US');
    if (amount == 0.0 || amount == 0.00) {
      return 'GH¢ 0.00';
    }
    return formatter.format(amount);
  }

  static String _dollarSymbol() {
    return '\$';
  }

  /// returns amount in thousands or hundreds
  static String dollar(double amount) {
    final formatter = NumberFormat('${_dollarSymbol()}#,##0.00', 'en_US');
    return formatter.format(amount);
  }

  static String clear(double amount) {
    final formatter = NumberFormat('###,##0.00', 'en_US');
    return formatter.format(amount);
  }
}
