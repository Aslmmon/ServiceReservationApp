import 'package:get/get.dart';
import '../../../domain/use_cases/booking/book_appointment_use_case.dart';
import 'package:flutter/material.dart'; // For context

class BookingController extends GetxController {
  final BookAppointmentUseCase _bookAppointmentUseCase = Get.find();

  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<String?> selectedTime = Rx<String?>(null);
  final RxBool isBooking = false.obs;
  final RxString bookingError = ''.obs;

  Future<void> bookAppointment(
    String specialistId,
    String userId,
    BuildContext context,
  ) async {
    if (selectedDate.value == null || selectedTime.value == null) {
      Get.snackbar('Error', 'Please select a date and time.');
      return;
    }

    isBooking.value = true;
    bookingError.value = '';
    final selectedDateTime = DateTime(
      selectedDate.value!.year,
      selectedDate.value!.month,
      selectedDate.value!.day,
      int.parse(selectedTime.value!.split(':')[0]),
      int.parse(selectedTime.value!.split(':')[1]),
    );

    try {
      final result = await _bookAppointmentUseCase.execute(
        userId,
        specialistId,
        selectedDateTime,
      );
      isBooking.value = false;
      Get.snackbar('Success', 'Appointment booked successfully!');
    } catch (e) {
      bookingError.value = 'Failed to book appointment.';
      Get.snackbar('Error', bookingError.value);
    }
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void selectTime(String time) {
    selectedTime.value = time;
  }
}
