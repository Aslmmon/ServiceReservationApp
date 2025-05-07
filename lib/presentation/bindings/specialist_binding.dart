import 'package:get/get.dart';
import 'package:service_reservation_app/data/data_source/firebase_specialist_data_source.dart'
    show FirebaseSpecialistRepository;
import 'package:service_reservation_app/domain/repositories/specialist_repository.dart'
    show SpecialistRepository;
import 'package:service_reservation_app/domain/use_cases/auth/get_current_user_use_case.dart';
import 'package:service_reservation_app/domain/use_cases/specialities/get_all_specialists_use_case.dart'
    show GetAllSpecialistsUseCase;
import 'package:service_reservation_app/domain/use_cases/specialities/get_specialist_by_id_use_case.dart'
    show GetSpecialistByIdUseCase;
import 'package:service_reservation_app/presentation/specialists/specialists_controller.dart'
    show SpecialistController;

import '../../domain/use_cases/auth/logout_user_use_case.dart';

class SpecialistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecialistRepository>(() => FirebaseSpecialistRepository());
    Get.lazyPut(
      () => GetAllSpecialistsUseCase(specialistRepository: Get.find()),
    );
    Get.lazyPut(
      () => GetSpecialistByIdUseCase(specialistRepository: Get.find()),
    );
    Get.lazyPut(() => SpecialistController());

    Get.lazyPut(() => LogoutUserUseCase(userRepository: Get.find()));

    Get.lazyPut(() => GetCurrentUserUseCase(userRepository: Get.find()));
  }
}
