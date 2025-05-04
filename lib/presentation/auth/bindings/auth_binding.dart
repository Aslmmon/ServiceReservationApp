import 'package:get/get.dart';
import 'package:service_reservation_app/presentation/auth/bindings/core_binding.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends CoreBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut(() => AuthController());
  }
}

