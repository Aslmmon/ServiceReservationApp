import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:service_reservation_app/utils/appStrings/AppStrings.dart';

class AuthValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.nameRequired;
    }
    if (value.length > 20) {
      return AppStrings.nameMaxLength;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    }
    if (!GetUtils.isEmail(value)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length > 20) {
      return AppStrings.passwordMaxLength;
    }
    if (value.length < 6) {
      return AppStrings.passwordMinLength;
    }
    return null;
  }
}
