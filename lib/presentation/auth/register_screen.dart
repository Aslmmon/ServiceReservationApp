import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/presentation/auth/auth_controller.dart';
import '../../utils/appColors/AppColors.dart';
import '../../utils/appStrings/AppStrings.dart';
import '../../utils/appTextStyle/AppTextStyles.dart';
import '../../utils/components/AppButton.dart' show ReusableButton;
import '../../utils/components/AppTextField.dart' show ReusableTextField;

class RegisterScreen extends GetView<AuthController> {
  RegisterScreen({super.key});

  final RxBool _obscurePassword = true.obs;

  // Reusable Error Message Widget
  Widget _buildErrorMessage() {
    return Obx(
      () =>
          controller.errorMessage.value.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(AppStrings.signUp, style: AppTextStyles.heading),
              const SizedBox(height: 32),
              // Image
              Image.asset(
                'assets/images/person.png', // Replace with your actual signup illustration
                height: 150, // Adjust height as needed
              ),
              const SizedBox(height: 32),
              ReusableTextField(
                labelText: AppStrings.fullNameLabel,
                controller: controller.nameController,
                keyboardType: TextInputType.name,
              ),
              ReusableTextField(
                labelText: AppStrings.emailLabel,
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              Obx(
                () => ReusableTextField(
                  labelText: AppStrings.passwordLabel,
                  controller: controller.passwordController,
                  obscureText: _obscurePassword.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.lightText,
                    ),
                    onPressed: () {
                      _obscurePassword.value = !_obscurePassword.value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => ReusableButton(
                  text: AppStrings.signUpButtonText,
                  isLoading: controller.isLoading.value,
                  onPressed: () async {
                    await controller.register();
                  },
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.alreadyHaveAccountQuestion,
                    style: AppTextStyles.label,
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      AppStrings.loginLink,
                      style: AppTextStyles.linkText,
                    ),
                  ),
                ],
              ),
              _buildErrorMessage(),
            ],
          ),
        ),
      ),
    );
  }
}
