import 'package:flutter/material.dart';
import 'package:service_reservation_app/data/models/appointment_model.dart';
import 'package:service_reservation_app/data/models/specialist_model.dart';
import '../../../utils/appStrings/AppStrings.dart';
import '../../../utils/components/AppButton.dart';
import '../../booking/confimationBottomSheet.dart';
import '../../booking/booking_controller.dart'; // Assuming this is the path
import 'package:get/get.dart';

class NextButtonView extends StatelessWidget {
  final Specialist? specialist;
  final DateTime? selectedDay;
  final TimeOfDay? selectedTime;
  final Function(Appointment) onBookAppointment; // Adjust the type if needed
  final BookingController bookingController = Get.find();

  NextButtonView({
    super.key,
    this.specialist,
    this.selectedDay,
    this.selectedTime,
   required this.onBookAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ReusableButton(
        text: AppStrings.nextReviewConfirm.tr,
        onPressed: () {
          if (selectedDay != null &&
              selectedTime != null &&
              specialist != null) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext bc) {
                return buildConfirmationBottomSheet(
                  context,
                  specialist?.name,
                  selectedDay,
                  selectedTime?.format(context),
                  specialist?.id,
                  (appointment) {
                    onBookAppointment(appointment);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
