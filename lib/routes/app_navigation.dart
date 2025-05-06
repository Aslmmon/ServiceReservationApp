import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/routes/app_routes.dart';

class AppNavigation extends GetxService {
  static AppNavigation get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> handleInitialNavigation() async {
    final User? initialUser = _auth.currentUser;
    if (initialUser == null) {
      if (Get.currentRoute != AppRoutes.login &&
          Get.currentRoute != AppRoutes.register) {
        goToLogin();
      }
    } else {
      if (Get.currentRoute != AppRoutes.home) {
        goToHome();
      }
    }
  }

  void goToHome() => Get.offAllNamed(
    AppRoutes.home,
  );

  void goToLogin() => Get.offAllNamed(AppRoutes.login);
}
