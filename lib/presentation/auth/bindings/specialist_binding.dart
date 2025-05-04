import 'package:get/get.dart';
import 'package:service_reservation_app/data/data_source/firebase_specialist_data_source.dart'
    show FirebaseSpecialistRepository;
import 'package:service_reservation_app/domain/repositories/specialist_repository.dart'
    show SpecialistRepository;
import 'package:service_reservation_app/domain/use_cases/specialities/get_all_specialists_use_case.dart'
    show GetAllSpecialistsUseCase;
import 'package:service_reservation_app/domain/use_cases/specialities/get_specialist_by_id_use_case.dart'
    show GetSpecialistByIdUseCase;
import 'package:service_reservation_app/presentation/auth/bindings/core_binding.dart';
import 'package:service_reservation_app/presentation/auth/controllers/SpecialistController.dart'
    show SpecialistController;


class SpecialistBinding extends CoreBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<SpecialistRepository>(() => FirebaseSpecialistRepository());
    Get.lazyPut(
      () => GetAllSpecialistsUseCase(specialistRepository: Get.find()),
    );
    Get.lazyPut(
      () => GetSpecialistByIdUseCase(specialistRepository: Get.find()),
    );
    Get.lazyPut(() => SpecialistController());
  }
}
