import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../../data/data_source/firebase_user_data_source.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/use_cases/auth/RegisterUserUseCase.dart';
import '../../../domain/use_cases/auth/login_user_use_case.dart';

class CoreBinding extends Bindings {
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
  }
}
