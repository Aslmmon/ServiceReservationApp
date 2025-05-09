import 'package:get/get.dart';
import 'package:service_reservation_app/data/models/appointment_model.dart';
import 'package:service_reservation_app/domain/use_cases/auth/get_current_user_use_case.dart';
import '../../domain/use_cases/booking/book_appointment_use_case.dart';

class BookingController extends GetxController {
  final BookAppointmentUseCase _bookAppointmentUseCase = Get.find();
  final GetCurrentUserUseCase _getCurrentUserUseCase = Get.find();
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<String?> selectedTime = Rx<String?>(null);
  final RxBool isBooking = false.obs;
  final RxString bookingError = ''.obs;

  Future<void> bookAppointment(Appointment appointment) async {
    isBooking.value = true;
    bookingError.value = '';
    print(" appointment is  ${appointment.userId.toString()}");
    try {
      await _bookAppointmentUseCase.execute(appointment);
      isBooking.value = false;
      Get.snackbar('Success', 'Appointment booked successfully!');
    } catch (e) {
      bookingError.value = 'Failed to book appointment.';
      Get.snackbar('Error', bookingError.value);
    }
  }

  String? getCurrentUserId() => _getCurrentUserUseCase.execute();
}
