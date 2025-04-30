import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/presentation/auth/controllers/auth_controller.dart'
    show AuthController;
import 'package:service_reservation_app/routes/app_routes.dart' show AppRoutes;

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : () async {
                            await controller.login();
                          },
                  child:
                      controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.register),
                child: const Text('Don\'t have an account? Register'),
              ),
              Obx(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
