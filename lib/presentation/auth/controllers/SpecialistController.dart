import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:get/get.dart';
import 'package:service_reservation_app/data/models/specialist_model.dart'
    show Specialist, createDummySpecialistList, specialistLists;
import 'package:service_reservation_app/domain/use_cases/specialities/get_all_specialists_use_case.dart'
    show GetAllSpecialistsUseCase;
import 'package:service_reservation_app/domain/use_cases/specialities/get_specialist_by_id_use_case.dart'
    show GetSpecialistByIdUseCase;
import '../../../routes/app_routes.dart';

class SpecialistController extends GetxController {
  final GetAllSpecialistsUseCase _getAllSpecialistsUseCase = Get.find();
  final GetSpecialistByIdUseCase _getSpecialistByIdUseCase = Get.find();

  final RxList<Specialist> _allSpecialists = <Specialist>[].obs;
  final RxList<Specialist> filteredSpecialists = <Specialist>[].obs;
  final Rxn<Specialist> selectedSpecialist = Rxn<Specialist>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxMap<String, List<Specialist>> specialistsByCategory =
      <String, List<Specialist>>{}.obs;

  @override
  void onInit() {
    // submitSpecialists();
    fetchSpecialists();
    super.onInit();
  }

  Future<void> fetchSpecialists() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _getAllSpecialistsUseCase.execute();

    isLoading.value = false;
    if (result != null) {
      _allSpecialists.assignAll(result);
      filterSpecialists(searchQuery.value); // Apply initial filtering
      _groupSpecialistsByCategory(_allSpecialists);
    } else {
      errorMessage.value = 'Failed to fetch specialists.';
    }
  }

  Future<void> submitSpecialists() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    errorMessage.value = '';
    isLoading.value = true;
    for (var value in specialistLists) {
      await db
          .collection("Specialists")
          .doc(value.id)
          .set(value.toFirestore())
          .onError(
            (e, _) => print("Error writing document for ${value.name}: $e"),
          );
    }

    isLoading.value = false;
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

  void filterSpecialists(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredSpecialists.assignAll(_allSpecialists);
    } else {
      filteredSpecialists.assignAll(
        _allSpecialists.where(
          (specialist) =>
              specialist.name.toLowerCase().contains(query.toLowerCase()) ||
              specialist.specialization.toLowerCase().contains(
                query.toLowerCase(),
              ),
        ),
      );
    }
    _groupSpecialistsByCategory(filteredSpecialists);
  }

  void _groupSpecialistsByCategory(List<Specialist> specialists) {
    specialistsByCategory.clear();
    for (var specialist in specialists) {
      if (!specialistsByCategory.containsKey(specialist.specialization)) {
        specialistsByCategory[specialist.specialization] = <Specialist>[];
      }
      specialistsByCategory[specialist.specialization]!.add(specialist);
    }
  }
}
