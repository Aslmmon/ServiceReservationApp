import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/data/models/appointment_model.dart';
import 'package:service_reservation_app/presentation/auth/auth_controller.dart';
import 'package:service_reservation_app/presentation/booking/booking_controller.dart';
import 'package:service_reservation_app/presentation/booking/components/BuildInfoRow.dart';
import 'package:service_reservation_app/presentation/specialists/specialists_controller.dart';
import 'package:service_reservation_app/utils/utils.dart';
import '../../domain/entities/appointment_status.dart';
import '../../utils/appColors/AppColors.dart';
import '../../utils/appStrings/AppStrings.dart';
import '../../utils/appTextStyle/AppTextStyles.dart';
import '../../utils/components/AppButton.dart';

Widget buildConfirmationBottomSheet(
  BuildContext context,
  String? specialistName,
  DateTime? selectedDate,
  String? selectedTimeFormatted,
  String? specialistId,
  Function(Appointment) onBookingClicked,
) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.reviewBooking,
          style: AppTextStyles.heading.copyWith(color: AppColors.darkText),
        ),
        const SizedBox(height: 16),
        InfoRow(
          label: AppStrings.specialist,
          value: specialistName ?? AppStrings.loading,
        ),
        InfoRow(
          label: AppStrings.date,
          value:
              selectedDate != null
                  ? selectedDate.formatDate()
                  : AppStrings.loading,
        ),

        InfoRow(
          label: AppStrings.time,
          value: selectedTimeFormatted ?? AppStrings.loading,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ReusableButton(
            text: AppStrings.confirmBooking,
            onPressed: () {
              if (specialistId != null &&
                  selectedDate != null &&
                  selectedTimeFormatted != null) {
                print("dateTime + {$selectedDate}");
                print("dateTimeFormated + {$selectedTimeFormatted}");

                onBookingClicked(
                  Appointment(
                    userId: Get.find<BookingController>().getCurrentUserId(),
                    specialistId: specialistId,
                    date: selectedDate.formatDate(),
                    time: selectedTimeFormatted,
                    status: AppointmentStatus.booked,
                  ),
                );
                Get.back(); // Close the bottom sheet
              } else {
                Get.snackbar(
                  AppStrings.error,
                  '${AppStrings.error}: ${AppStrings.missingDetails}',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.darkText.withOpacity(0.8),
                  colorText: Colors.white,
                );
              }
            },
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Get.back(); // Close the bottom sheet
            },
            child: Text(
              AppStrings.cancel,
              style: AppTextStyles.subHeading.copyWith(color: Colors.grey),
            ),
          ),
        ),
      ],
    ),
  );
}
