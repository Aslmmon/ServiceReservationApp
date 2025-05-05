import 'package:get/get.dart';
import '../../../data/data_source/firebase_user_data_source.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/use_cases/auth/RegisterUserUseCase.dart';
import '../../../domain/use_cases/auth/login_user_use_case.dart';
import '../../domain/use_cases/auth/logout_user_use_case.dart';
import '../auth/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(() => FirebaseUserRepository(), fenix: true);
    Get.lazyPut(
      () => RegisterUserUseCase(userRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => LoginUserUseCase(userRepository: Get.find()),
      fenix: true,
    );

    Get.lazyPut(
      () => LogoutUserUseCase(userRepository: Get.find()),
      fenix: true,
    );

    // Global Controller
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}
