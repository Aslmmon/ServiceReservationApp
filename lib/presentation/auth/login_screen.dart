import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/presentation/auth/auth_controller.dart';
import 'package:service_reservation_app/routes/app_routes.dart';
import '../../utils/appAssets/AppAssets.dart';
import '../../utils/appColors/AppColors.dart';
import '../../utils/appStrings/AppStrings.dart';
import '../../utils/appTextStyle/AppTextStyles.dart';
import '../../utils/components/AppButton.dart' show ReusableButton;
import '../../utils/components/AppTextField.dart' show ReusableTextField;

class LoginScreen extends GetView<AuthController> {
  LoginScreen({super.key});

  final RxBool _obscurePassword = true.obs;

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
              Text(AppStrings.welcomeBack, style: AppTextStyles.subHeading),
              const SizedBox(height: 5),
              Text(AppStrings.login, style: AppTextStyles.heading),
              const SizedBox(height: 5),
              Hero(
                tag: AppStrings.heroTag,
                child: Image.asset(AppAssets.logo, height: 200),
              ),
              const SizedBox(height: 5),
              ReusableTextField(
                labelText: AppStrings.emailLabel,
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                maxLength: 40, // Email max length
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.forgotPassword,
                    style: AppTextStyles.linkText,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => ReusableButton(
                  text: AppStrings.loginButtonText,
                  isLoading: controller.isLoading.value,
                  onPressed: () async {
                    await controller.login();
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.noAccountQuestion,
                    style: AppTextStyles.label,
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.register),
                    child: Text(
                      AppStrings.signUpLink,
                      style: AppTextStyles.linkText,
                    ),
                  ),
                ],
              ),
              _buildErrorMessage(), // Using the reusable error message widget
            ],
          ),
        ),
      ),
    );
  }

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
}
