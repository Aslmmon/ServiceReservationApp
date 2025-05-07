import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/domain/use_cases/auth/RegisterUserUseCase.dart'
    show RegisterUserUseCase;
import 'package:service_reservation_app/presentation/auth/validators/AuthValidators.dart';
import 'package:service_reservation_app/utils/appStrings/AppStrings.dart';
import '../../../domain/use_cases/auth/login_user_use_case.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final RegisterUserUseCase _registerUserUseCase = Get.find();
  final LoginUserUseCase _loginUserUseCase = Get.find();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final nameError = AuthValidators.validateName(name);
    final emailError = AuthValidators.validateEmail(email);
    final passwordError = AuthValidators.validatePassword(password);

    if (nameError != null || emailError != null || passwordError != null) {
      errorMessage.value = nameError ?? emailError ?? passwordError!;
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    final result = await _registerUserUseCase.execute(name, email, password);
    isLoading.value = false;
    if (result != null) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      errorMessage.value = AppStrings.registrationFailed;
    }
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final emailError = AuthValidators.validateEmail(email);
    final passwordError = AuthValidators.validatePassword(password);

    if (emailError != null || passwordError != null) {
      errorMessage.value = emailError ?? passwordError!;
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    final result = await _loginUserUseCase.execute(email, password);
    isLoading.value = false;
    if (result != null) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      errorMessage.value = AppStrings.loginGenericError;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
