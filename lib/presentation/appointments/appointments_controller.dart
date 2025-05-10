import 'package:get/get.dart';
import 'package:service_reservation_app/utils/appStrings/AppStrings.dart';

import '../../../data/models/appointment_model.dart';
import '../../../domain/use_cases/appointment/CancelAppointmentUseCase.dart';
import '../../domain/use_cases/appointment/GetUserAppointmentsUseCase.dart';
import '../specialists/specialists_controller.dart';

class MyAppointmentsController extends GetxController {
  final GetUserAppointmentsUseCase _getUserAppointmentsUseCase = Get.find();
  final CancelAppointmentUseCase _cancelAppointmentUseCase = Get.find();
  final RxList<Appointment> appointments = <Appointment>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isCancelling = false.obs;

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
    isCancelling.value = true;
    errorMessage.value = '';
    try {
      await _cancelAppointmentUseCase.execute(appointmentId);
      appointments.removeWhere((appt) => appt.id == appointmentId);
      Get.snackbar(AppStrings.ok, AppStrings.cancelAppointmentSuccess);
      await Get.find<SpecialistController>().fetchSpecialists();

      appointments.refresh();
    } catch (e) {
      errorMessage.value = '${AppStrings.cancelAppointmentFailure}: ${e.toString()}';
      Get.snackbar(AppStrings.cancel, errorMessage.value);
    } finally {
      isCancelling.value = false;
    }
  }
}
