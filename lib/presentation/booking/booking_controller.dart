import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/data/models/appointment_model.dart';
import 'package:service_reservation_app/domain/use_cases/auth/get_current_user_use_case.dart';
import 'package:service_reservation_app/presentation/appointments/appointments_controller.dart';
import 'package:service_reservation_app/presentation/specialists/specialists_controller.dart';
import '../../domain/use_cases/booking/book_appointment_use_case.dart';

class BookingController extends GetxController {
  final BookAppointmentUseCase _bookAppointmentUseCase = Get.find();
  final GetCurrentUserUseCase _getCurrentUserUseCase = Get.find();
  final RxBool isBooking = false.obs;
  final RxString bookingError = ''.obs;

  Future<bool> bookAppointment(Appointment appointment) async {
    isBooking.value = true;
    bookingError.value = '';
    try {
      debugPrint(isBooking.value.toString());
      await _bookAppointmentUseCase.execute(appointment);
      await Get.find<MyAppointmentsController>().fetchUserAppointments();
      await Get.find<SpecialistController>().fetchSpecialists();
      Get.snackbar('Success', 'Appointment booked successfully!');
      return true;
    } catch (e) {
      bookingError.value = 'Failed to book appointment.';
      Get.snackbar('Error', bookingError.value);
      return false;
    }
  }

  String? getCurrentUserId() => _getCurrentUserUseCase.execute();
}
