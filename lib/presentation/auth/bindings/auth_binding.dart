import 'package:get/get.dart';
import 'package:service_reservation_app/data/data_source/firebase_user_data_source.dart'
    show FirebaseUserRepository;
import 'package:service_reservation_app/domain/use_cases/auth/RegisterUserUseCase.dart'
    show RegisterUserUseCase;
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/use_cases/auth/login_user_use_case.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(() => FirebaseUserRepository());
    Get.lazyPut(() => RegisterUserUseCase(userRepository: Get.find()));
    Get.lazyPut(() => LoginUserUseCase(userRepository: Get.find()));
    Get.lazyPut(() => AuthController());
  }
}
