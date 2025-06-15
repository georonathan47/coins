import 'package:get/get.dart';

/// Extension on Strings
extension StringExtension on String {
//   /// Convert the first string to capital case≈
//   String capitalize() =>
//       length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String truncate(int maxLength) =>
      length > maxLength ? '${substring(0, maxLength)}...' : this;
}

extension EnumToString on Enum {
  String get displayName {
    final enumName = toString().split('.').last;

    // Special cases handling
    if (enumName == 'national_ID') return 'National ID';

    // General case: insert space before uppercase letters and capitalize each word
    return enumName
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])|([A-Z])([A-Z][a-z])'),
          (Match match) {
            if (match.group(1) != null && match.group(2) != null) {
              return '${match.group(1)} ${match.group(2)}';
            } else if (match.group(3) != null && match.group(4) != null) {
              return '${match.group(3)} ${match.group(4)}';
            }
            return match[0]!;
          },
        )
        .split(' ')
        .map((word) => word.capitalize)
        .join(' ');
  }
}
