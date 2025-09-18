

import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please enter your email address.";
    } else if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    return null;
  }

  static String? validateGstinNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final gstinRegex = RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
    if (!gstinRegex.hasMatch(value)) {
      return "Please enter a valid 15-character GSTIN.";
    }
    return null;
  }

  static String? validatePan(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your PAN.";
    }
    final RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    if (!panRegex.hasMatch(value)) {
      return "Invalid PAN format. Example: ABCDE1234F.";
    }
    return null;
  }

  static String? validateGST(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter GSTIN.";
    }
    final RegExp gstinRegExp =
    RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
    if (!gstinRegExp.hasMatch(value)) {
      return "Invalid GSTIN format.";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? confirmValue) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password.';
    }
    if (value != confirmValue) {
      return "Passwords do not match.";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number.';
    } else if (value.length != 10) {
      return 'Enter a valid 10-digit phone number.';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name.';
    }
    return null;
  }

  static String? validateNotEmptyFiled(String? value) {
    if (value == null || value.isEmpty) {
      return "This field cannot be empty.";
    }
    return null;
  }

  static String? validateUnlockPin(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your PIN.";
    } else if (value.length != 4) {
      return "PIN must be exactly 4 digits.";
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your address.";
    }
    return null;
  }

  static String? validateAmountGreaterThan(String? value, double greaterThan) {
    if (value == null || value.isEmpty) {
      return "Please enter an amount.";
    } else if (double.parse(value) <= greaterThan) {
      return "Amount must be greater than $greaterThan.";
    }
    return null;
  }

  static String? validateUpiId(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your UPI ID.";
    }
    RegExp regExp = RegExp(r"^[a-zA-Z0-9.\-_]{2,49}@[a-zA-Z._]{2,49}$");
    if (!regExp.hasMatch(value)) {
      return "Invalid UPI ID format. Example: example@upi.";
    }
    return null;
  }

  static String? validateAadhar(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your Aadhaar number.";
    }
    if (value.length != 12) {
      return "Aadhaar number must be exactly 12 digits.";
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select a valid date.";
    }
    return null;
  }

  static String? validateTime(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select a valid time.";
    }
    return null;
  }

  static String? validateAccountNo(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your account number.";
    }
    if (value.length < 9 || value.length > 18) {
      return "Account number must be between 9 to 18 digits.";
    }
    return null;
  }

  static String? validateIFSC(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter IFSC code.";
    }
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value)) {
      return "Invalid IFSC code. Example: SBIN0001234.";
    }
    return null;
  }
}
