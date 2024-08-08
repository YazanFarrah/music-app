import 'package:client/core/utils/regex_patterns_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppValidation {
  static String? identifierValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "Please enter your email or phone number";
    }

    RegExp emailRegex = RegExp(RegexPatterns.emailPattern);
    RegExp onlyNumbersRegex = RegExp(RegexPatterns.onlyNumbers);

    // Check if the value is a valid email
    if (emailRegex.hasMatch(value)) {
      return null; // Valid email, return null
    }

    // Check if the value is a valid phone number
    if (onlyNumbersRegex.hasMatch(value.replaceAll('+', '')) &&
        value.length > 8) {
      return null; // Valid phone number, return null
    }

    // If neither email nor phone number, return an error message
    return "Invalid email or phone number";
  }

  static String? emailValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "emptyEmail".tr();
    }

    RegExp emailRegex = RegExp(RegexPatterns.emailPattern);

    // Check if the value is a valid email
    if (emailRegex.hasMatch(value)) {
      return null; // Valid email, return null
    } else {
      return "invalidEmail".tr();
    }
  }

  static String? phoneNumberValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.locale == const Locale('en')
          ? "Phone number can't be empty"
          : "رقم الهاتف مطلوب";
    }

    // Check if the value is a valid phone number
    if (isPhoneNumber(value)) {
      return null; // Valid phone number, return null
    } else {
      return context.locale == const Locale('en')
          ? "Invalid phone number"
          : "رقم هاتف غير صحيح";
    }
  }

  static String? nameValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.locale == const Locale('en')
          ? "Name can't be empty"
          : "الاسم مطلوب";
    }
    return null;
  }

  static String? isNotEmpty(String value, BuildContext context) {
    if (value.isEmpty) {
      return context.locale == const Locale('en')
          ? "Can't be empty"
          : "هذا الحقل مطلوب";
    }
    return null;
  }

  static String? passwordValidator(String? value, BuildContext context) {
    if (value != null && value.length < 5) {
      return context.locale == const Locale('en')
          ? "Invalid password"
          : "كلمة المرور غير صالحة";
    }

    return null;
  }

  static bool isEmail(String value) {
    RegExp emailRegex = RegExp(RegexPatterns.emailPattern);
    return emailRegex.hasMatch(value);
  }

  static bool isPhoneNumber(String value) {
    // Remove any '+' from the phone number before checking
    String cleanedNumber = value.replaceAll('+', '');

    // Check if the cleaned number contains only numeric characters
    RegExp onlyNumbersRegex = RegExp(RegexPatterns.onlyNumbers);
    if (onlyNumbersRegex.hasMatch(cleanedNumber)) {
      return true;
    }

    // Check if the cleaned number contains at least one numeric character
    RegExp containsNumbersRegex = RegExp(RegexPatterns.containsNumbers);
    return containsNumbersRegex.hasMatch(cleanedNumber);
  }
}
