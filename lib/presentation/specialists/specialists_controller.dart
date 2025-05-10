import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:service_reservation_app/data/models/specialist_model.dart'
    show Specialist, specialistLists;
import 'package:service_reservation_app/data/models/user_model.dart';
import 'package:service_reservation_app/domain/use_cases/specialities/get_all_specialists_use_case.dart'
    show GetAllSpecialistsUseCase;
import 'package:service_reservation_app/domain/use_cases/specialities/get_specialist_by_id_use_case.dart'
    show GetSpecialistByIdUseCase;

import '../../domain/use_cases/auth/logout_user_use_case.dart';
import '../../routes/app_routes.dart';

class SpecialistController extends GetxController {
  final GetAllSpecialistsUseCase _getAllSpecialistsUseCase = Get.find();
  final GetSpecialistByIdUseCase _getSpecialistByIdUseCase = Get.find();
  final LogoutUserUseCase _logoutUserUseCase = Get.find();

  final RxList<Specialist> _allSpecialists = <Specialist>[].obs;
  final RxList<Specialist> filteredSpecialists = <Specialist>[].obs;
  final Rxn<Specialist> selectedSpecialist = Rxn<Specialist>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxMap<String, List<Specialist>> specialistsByCategory =
      <String, List<Specialist>>{}.obs;
  final TextEditingController searchController = TextEditingController();

  final Rxn<UserModel> loggedInUser = Rxn<UserModel>();
  final box = GetStorage();

  @override
  void onInit() {
    fetchSpecialists();
    searchController.addListener(() {
      filterSpecialists(searchController.text);
    });
    super.onInit();
  }

  Future<void> fetchSpecialists() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _getAllSpecialistsUseCase.execute();

    isLoading.value = false;
    if (result.isNotEmpty) {
      _allSpecialists.assignAll(result);
      filterSpecialists(searchQuery.value); // Apply initial filtering
      _groupSpecialistsByCategory(_allSpecialists);
    } else {
      errorMessage.value = 'Failed to fetch specialists.';
    }
  }

  UserModel? getUserLocal() {
    final userMap = box.read<Map<String, dynamic>>('user');
    if (userMap != null) {
      return UserModel(
        id: userMap['id'] as String? ?? '',
        name: userMap['name'] as String? ?? '',
        email: userMap['email'] as String? ?? '',
      );
    }
    return null;
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
            (e, _) =>
                debugPrint("Error writing document for ${value.name}: $e"),
          );
    }

    isLoading.value = false;
  }

  Future<void> logout() async {
    try {
      _logoutUserUseCase.execute().whenComplete(() {
        Get.offAllNamed(AppRoutes.login);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  UserModel? getUser() {
    return loggedInUser.value;
  }

  Future<void> getSpecialistDetails(String id) async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _getSpecialistByIdUseCase.execute(id);
    isLoading.value = false;
    if (result != null) {
      selectedSpecialist.value = result;
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

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
