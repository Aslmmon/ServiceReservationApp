import 'package:get/get.dart';

import '../../../data/data_source/firebase_user_data_source.dart'
    show FirebaseUserRepository;
import '../../../data/models/appointment_model.dart' show Appointment;
import '../../../domain/use_cases/appointment/CancelAppointmentUseCase.dart'
    show CancelAppointmentUseCase;
import '../../../domain/use_cases/appointment/GetUserAppointmentsUseCase.dart'
    show GetUserAppointmentsUseCase;

class MyAppointmentsController extends GetxController {
  final GetUserAppointmentsUseCase _getUserAppointmentsUseCase = Get.find();
  final CancelAppointmentUseCase _cancelAppointmentUseCase = Get.find();
  final FirebaseUserRepository _userRepository = Get.find();

  final RxList<Appointment> appointments = <Appointment>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchUserAppointments();
    super.onInit();
  }

  Future<void> fetchUserAppointments() async {
    isLoading.value = true;
    errorMessage.value = '';
    final user = await _userRepository.getCurrentUser();

    if (user != null) {
      final result = await _getUserAppointmentsUseCase.execute(user.id);
      isLoading.value = false;
      if (result != null) {
        appointments.assignAll(result);
      } else {
        errorMessage.value = 'Failed to fetch your appointments.';
      }
    } else {
      isLoading.value = false;
      errorMessage.value = 'User not logged in.';
    }
  }

  Future<void> cancelAppointment(String appointmentId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _cancelAppointmentUseCase.execute(appointmentId);
      isLoading.value = false;
      appointments.removeWhere((appt) => appt.id == appointmentId);
      Get.snackbar('Success', 'Appointment cancelled successfully!');
      // Optionally, you might want to just update the local list
      // instead of refetching all appointments:
      // appointments.refresh();
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to cancel appointment: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value);
    }
  }
}
