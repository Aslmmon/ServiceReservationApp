import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/domain/use_cases/auth/RegisterUserUseCase.dart'
    show RegisterUserUseCase;
import 'package:service_reservation_app/domain/use_cases/auth/logout_user_use_case.dart';
import '../../../domain/use_cases/auth/login_user_use_case.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final RegisterUserUseCase _registerUserUseCase = Get.find();
  final LoginUserUseCase _loginUserUseCase = Get.find();
  final LogoutUserUseCase _logoutUserUseCase = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> register() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _registerUserUseCase.execute(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    isLoading.value = false;
    if (result != null) {
      // Registration successful, navigate to specialist list
      Get.offAllNamed(AppRoutes.home);
    } else {
      // Registration failed, show error message
      errorMessage.value = 'Registration failed. Please try again.';
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _loginUserUseCase.execute(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    isLoading.value = false;
    if (result != null) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      errorMessage.value = 'Login failed. Invalid email or password.';
    }
  }

  Future<void> logout() async {
    try {
      _logoutUserUseCase.execute().whenComplete(() {
        Get.offAllNamed(AppRoutes.login);
      });
    } catch (e) {
      print('Error signing out: $e');
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
