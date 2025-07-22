import 'package:intl_phone_field/phone_number.dart';

class TValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.+]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static Future<String?> validatePhoneNumber(PhoneNumber? value) async {
    try {
      final number = value!.number.replaceAll(' ', '').replaceAll('+', '');
      final intNumber = int.tryParse(number);
      if (intNumber!.abs() < 9) {
        return 'Phone number is required.';
      }

      // Regular expression for phone number validation (assuming a 10-digit US phone number format)
      final phoneRegExp = RegExp(r'^\d{9,12}$');

      if (!phoneRegExp.hasMatch(intNumber.toString())) {
        return '${9 - intNumber.toString().length} digits more';
      }

      return null;
    } on FormatException {
      return 'Phone number should be a number❌';
    }
  }

  static String? validatePassport(String? value) {
    if (value == null || value.isEmpty) {
      return 'Passport is required.';
    }

    // Regular expression for passport validation - properly formatted for Dart
    final oldPassportRegex = RegExp(
      r'^[A-Z]{1,2}[0-9]{7}$',
      caseSensitive: false,
    );
    final newPassportRegex = RegExp(
      r'^([A-Z]{3})-([A-Z]{2})-([0-9]{6})$',
      caseSensitive: false,
    );

    // Check if it matches EITHER format
    if (oldPassportRegex.hasMatch(value) || newPassportRegex.hasMatch(value)) {
      return null;
    } else {
      return 'Invalid passport number.❌ Passport should be in the format: G1234567 or GHA-AD-123456';
    }
  }

  static String? validateNationalID(String? value) {
    if (value == null || value.isEmpty) {
      return 'National ID is required. ';
    }

    // Regular expression for national ID validation
    final nationalIDRegExp = RegExp(r'^[0-9]{13}$');

    if (!nationalIDRegExp.hasMatch(value)) {
      return 'Invalid national ID number. ❌';
    }

    return null;
  }

  static String? validateVoterID(String? value) {
    if (value == null || value.isEmpty) {
      return 'Voter ID is required.';
    }

    // Regular expression for voter ID validation
    final voterIDRegExp = RegExp(r'^[A-Z]{3}[0-9]{7}$');

    if (!voterIDRegExp.hasMatch(value)) {
      return 'Invalid voter ID number. ❌';
    }

    return null;
  }

  static String? validateDriversLicense(String? value) {
    if (value == null || value.isEmpty) {
      return 'Driver\'s License is required.';
    }

    // Regular expression for driver's license validation
    final driversLicenseRegExp = RegExp(r'^[A-Z]{2}[0-9]{8}$');

    if (!driversLicenseRegExp.hasMatch(value)) {
      return 'Invalid driver\'s license number. ❌';
    }

    return null;
  }

  static String? validateNHISCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'NHIS Card is required.';
    }

    // Regular expression for NHIS card validation
    final nhisCardRegExp = RegExp(r'^[A-Z]{2}[0-9]{8}$');

    if (!nhisCardRegExp.hasMatch(value)) {
      return 'Invalid NHIS card number. ❌';
    }

    return null;
  }

  static String? validatePoints(String? value) {
    try {
      if (value!.isEmpty) {
        return 'Points is required.';
      } else if (int.tryParse(value) == null) {
        return 'Points entered must be a number!';
      } else if (int.parse(value) < 0) {
        return 'Points entered must be a positive number!';
      }

      return null;
    } on FormatException {
      return 'Points entered must be a number!';
    }
  }

  static String? validateLink(String? value) {
    if (value!.isEmpty) {
      return 'Link is required.';
    } else if (!value.contains('https://')) {
      return 'Link must be in format: https://example.com';
    }

    return null;
  }

  // static String? validateStudentID(String? value) {
  // 	if (value == null || value.isEmpty) {
  // 		return 'Student ID is required.';
  // 	}

  // 	// Regular expression for student ID validation
  // 	final studentIDRegExp = RegExp(r'^[A-Z]{2}[0-9]{6}$');
  // 	return null;

  // }

  // Add more custom validators as needed for your specific requirements.
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required.';
    }

    if (value.length < 3) {
      return 'Name is too short';
    }

    return null;
  }

  static String? validateMiddleName(String? value, {bool isOptional = false}) {
    if (value == null || value.isEmpty) {
      return null;
    }

    // Regex to allow only alphabetic characters and spaces
    final nameRegExp = RegExp(r'^[a-zA-Z ]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Middle name can only contain letters and spaces';
    }

    return null;
  }

  static String? validateLongDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required.';
    }

    if (value.length < 20) {
      return 'Description cannot be less than 20 characters.';
    }

    return null;
  }

  static String? validateWalletAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wallet address is required.';
    }

    if (value.length < 32) {
      return 'Wallet address cannot be less than 32 characters.';
    }

    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required.';
    }

    final numValue = double.tryParse(value);

    if (numValue == null) {
      return 'Please enter a valid number.';
    }

    if (numValue <= 0 || numValue.isNaN || numValue.isInfinite) {
      return 'Please enter a valid positive amount.';
    }

    if (numValue > double.maxFinite) {
      return 'Amount is too large.';
    }
    return null;
  }

  static String? validateShortDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required.';
    }

    if (value.length < 10) {
      return 'Description cannot be less than 10 characters.';
    }

    return null;
  }

  /// Validates ID  and needs to be more than 6 characters
  static String? id(String? value) {
    const pattern = r'(^[A-Z]{3}-[0-9]{9}-[A-Z0-9]{1})';
    final regExp = RegExp(pattern);
    if (regExp.hasMatch(value!) && value.trim().isNotEmpty) {
      if (value.trim().length < 15) {
        return 'Invalid National ID Entered ❌';
      }
      return null;
    } else if (value.trim().isEmpty) {
      return 'National ID is required ❌';
    } else if (!regExp.hasMatch(value)) {
      return 'National ID must match the format: GHA-123456789-0 ❌';
    }
    return null;
  }

  static String? intlId(String? value) {
    const pattern = r'(^[a-zA-Z ]*$)';
    final regExp = RegExp(pattern);
    if (regExp.hasMatch(value!) && value.trim().isNotEmpty) {
      if (value.trim().length < 5) {
        return 'Invalid National ID Entered. ❌';
      }
      return null;
    } else if (value.trim().isEmpty) {
      return 'National ID is required. ❌';
    }
    return null;
  }

  static String? dateOfBirth(String? date) {
    if (date == null || date.isEmpty) {
      return null;
    } else {
      final DateTime now = DateTime.now();
      final DateTime minimumDate = DateTime(now.year - 18, now.month, now.day);

      if (DateTime.parse(date).isAfter(minimumDate)) {
        return 'You must be 18 years and above to qualify';
      }
    }
    return null;
  }

  static String? validateTransactionHash(String? value) {
    if (value == null || value.isEmpty) {
      return 'Transaction hash is required';
    }
    if (value.length < 64) {
      return 'Transaction hash must be at least 64 characters long';
    }
    return null;
  }
}
