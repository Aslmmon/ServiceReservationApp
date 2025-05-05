import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/appColors/AppColors.dart';
import '../../utils/appStrings/AppStrings.dart';
import '../../utils/appTextStyle/AppTextStyles.dart';
import '../../utils/components/AppButton.dart'; // Assuming you have this

Widget buildConfirmationBottomSheet(
  BuildContext context,
  String? specialistName,
  DateTime? selectedDate,
  String? selectedTimeFormatted,
  String? specialistId,
  VoidCallback onBookingClicked,
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
        _buildInfoRow(
          AppStrings.specialist,
          specialistName ?? AppStrings.loading,
        ),
        _buildInfoRow(
          AppStrings.date,
          selectedDate != null
              ? DateFormat('EEEE, MMMM d, y').format(selectedDate!)
              : AppStrings.loading,
        ),
        _buildInfoRow(
          AppStrings.time,
          selectedTimeFormatted ?? AppStrings.loading,
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
                print(
                  'Confirming booking for Specialist ID: $specialistId on ${selectedDate.toLocal()} at $selectedTimeFormatted',
                );
                onBookingClicked();
                Get.back(); // Close the bottom sheet
                _showBookingSuccessSnackbar(
                  context,
                  selectedDate,
                  selectedTimeFormatted,
                );
              } else {
                Get.snackbar(
                  AppStrings.error,
                  '${AppStrings.error}: Missing booking details. Please try again.',
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
              style: AppTextStyles.heading.copyWith(color: Colors.grey),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.heading.copyWith(color: AppColors.darkText),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.subHeading.copyWith(color: AppColors.darkText),
          ),
        ),
      ],
    ),
  );
}

void _showBookingSuccessSnackbar(
  BuildContext context,
  DateTime? date,
  String? time,
) {
  final formattedDateTime =
      date != null && time != null
          ? DateFormat('EEEE, MMMM d, y \'at\' h:mm a').format(
            DateTime.parse('${DateFormat('yyyy-MM-dd').format(date)} $time'),
          )
          : 'N/A';
  Get.snackbar(
    AppStrings.bookingSuccessful,
    '${AppStrings.yourAppointmentIsConfirmed}\n$formattedDateTime',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.darkText.withOpacity(0.8),
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
  );
}

// Add this to your AppStrings file
extension AppStringsExtension on AppStrings {
  static const String cancel = 'Cancel';
}
