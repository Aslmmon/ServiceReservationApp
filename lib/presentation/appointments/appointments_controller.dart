import 'package:get/get.dart';
import 'package:service_reservation_app/utils/appStrings/AppStrings.dart';

import '../../../data/models/appointment_model.dart';
import '../../../domain/use_cases/appointment/CancelAppointmentUseCase.dart';
import '../../domain/use_cases/appointment/GetUserAppointmentsUseCase.dart';

class MyAppointmentsController extends GetxController {
  final GetUserAppointmentsUseCase _getUserAppointmentsUseCase = Get.find();
  final CancelAppointmentUseCase _cancelAppointmentUseCase = Get.find();
  final RxList<Appointment> appointments = <Appointment>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxMap<String, RxBool> isCancelling = <String, RxBool>{}.obs;

  @override
  void onInit() {
    fetchUserAppointments();
    super.onInit();
  }

  Future<void> fetchUserAppointments() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _getUserAppointmentsUseCase.execute();
    isLoading.value = false;
    appointments.assignAll(result);
  }

  Future<void> cancelAppointment(String appointmentId) async {
    isCancelling[appointmentId] =
        true.obs; // Set loading to true for this appointment
    errorMessage.value = '';
    try {
      await _cancelAppointmentUseCase.execute(appointmentId);
      appointments.removeWhere((appt) => appt.id == appointmentId);
      Get.snackbar(AppStrings.ok, AppStrings.cancelAppointmentSuccess);
      appointments.refresh();
    } catch (e) {
      errorMessage.value =
          '${AppStrings.cancelAppointmentFailure}: ${e.toString()}';
      Get.snackbar(AppStrings.cancel, errorMessage.value);
    } finally {
      isCancelling[appointmentId]?.value = false; // Set loading to false
      isCancelling.remove(appointmentId); // Clean up the map
    }
  }
}
