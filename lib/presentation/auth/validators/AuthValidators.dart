import 'package:get/get_utils/src/get_utils/get_utils.dart';

class AuthValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length > 20) {
      return 'Name cannot exceed 20 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length > 20) {
      return 'Password cannot exceed 20 characters';
    }
    if (value.length < 6) {
      return 'Password cannot be less than 6 characters';
    }
    return null;
  }
}
