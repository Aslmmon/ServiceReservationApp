import 'package:get/get.dart';
import '../../domain/use_cases/booking/book_appointment_use_case.dart';

class BookingController extends GetxController {
  final BookAppointmentUseCase _bookAppointmentUseCase = Get.find();

  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<String?> selectedTime = Rx<String?>(null);
  final RxBool isBooking = false.obs;
  final RxString bookingError = ''.obs;

  Future<void> bookAppointment(
    String specialistId,
    String userId,
    DateTime datetime,
  ) async {

    isBooking.value = true;
    bookingError.value = '';

    print(
      'Confirming booking for Specialist ID: $specialistId on ${datetime.toLocal()} userId : $userId',
    );
    try {
      await _bookAppointmentUseCase.execute(
        userId,
        specialistId,
        datetime,
      );
      isBooking.value = false;
      Get.snackbar('Success', 'Appointment booked successfully!');
    } catch (e) {
      bookingError.value = 'Failed to book appointment.';
      Get.snackbar('Error', bookingError.value);
    }
  }


}
