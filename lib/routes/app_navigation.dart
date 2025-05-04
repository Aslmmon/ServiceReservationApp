import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/routes/app_routes.dart';

class AppNavigation extends GetxService {
  static AppNavigation get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool _isFirstLaunch = true.obs;

  Future<void> handleInitialNavigation() async {
    if (!_isFirstLaunch.value) {
      return;
    }
    _isFirstLaunch.value = false;
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        // User is not logged in, navigate to Login
        if (Get.currentRoute != AppRoutes.login &&
            Get.currentRoute != AppRoutes.register) {
          Get.offAllNamed(AppRoutes.login);
        }
      } else {
        // User is logged in, navigate to Home
        if (Get.currentRoute != AppRoutes.home) {
          Get.offAllNamed(AppRoutes.home);
        }
      }
    });

    // Check initial state immediately on service initialization
    final User? initialUser = _auth.currentUser;
    if (initialUser == null) {
      if (Get.currentRoute != AppRoutes.login &&
          Get.currentRoute != AppRoutes.register) {
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      if (Get.currentRoute != AppRoutes.home) {
        Get.offAllNamed(AppRoutes.home);
      }
    }
  }

  // Method to navigate to Home (can be called from AuthController)
  void goToHome() {
    Get.offAllNamed(AppRoutes.home);
  }

  // Method to navigate to Login (can be called from AuthController or logout)
  void goToLogin() {
    Get.offAllNamed(AppRoutes.login);
  }
}
