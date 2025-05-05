import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/models/appointment_model.dart';
import '../../../domain/use_cases/appointment/CancelAppointmentUseCase.dart';
import '../../domain/use_cases/appointment/GetUserAppointmentsUseCase.dart';

class MyAppointmentsController extends GetxController {
  final GetUserAppointmentsUseCase _getUserAppointmentsUseCase = Get.find();
  final CancelAppointmentUseCase _cancelAppointmentUseCase = Get.find();

  /// @TODO : move FirebaseAuth to data source Layer
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    print("user uid is + ${_auth.currentUser!.uid}");

    final result = await _getUserAppointmentsUseCase.execute(
      _auth.currentUser!.uid,
    );
    isLoading.value = false;
    if (result != null) {
      appointments.assignAll(result);
    } else {
      errorMessage.value = 'Failed to fetch your appointments.';
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
