import 'package:get/get.dart';
import 'package:service_reservation_app/data/models/specialist_model.dart' show Specialist;
import 'package:service_reservation_app/domain/use_cases/specialities/get_all_specialists_use_case.dart' show GetAllSpecialistsUseCase;
import 'package:service_reservation_app/domain/use_cases/specialities/get_specialist_by_id_use_case.dart' show GetSpecialistByIdUseCase;
import '../../../routes/app_routes.dart';

class SpecialistController extends GetxController {
  final GetAllSpecialistsUseCase _getAllSpecialistsUseCase = Get.find();
  final GetSpecialistByIdUseCase _getSpecialistByIdUseCase = Get.find();

  final RxList<Specialist> specialists = <Specialist>[].obs;
  final Rxn<Specialist> selectedSpecialist = Rxn<Specialist>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchSpecialists();
    super.onInit();
  }

  Future<void> fetchSpecialists() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _getAllSpecialistsUseCase.execute();
    isLoading.value = false;
    if (result != null) {
      specialists.assignAll(result);
    } else {
      errorMessage.value = 'Failed to fetch specialists.';
    }
  }

  Future<void> getSpecialistDetails(String id) async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _getSpecialistByIdUseCase.execute(id);
    isLoading.value = false;
    if (result != null) {
      selectedSpecialist.value = result;
      Get.toNamed(AppRoutes.specialistDetail, arguments: result);
    } else {
      errorMessage.value = 'Failed to fetch specialist details.';
    }
  }
}