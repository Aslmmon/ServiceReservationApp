import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

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
          'Review Your Booking',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Specialist: ${specialistName ?? 'N/A'}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Date: ${selectedDate != null ? DateFormat.yMMMMd().format(selectedDate!) : 'N/A'}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Time: ${selectedTimeFormatted ?? 'N/A'}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (specialistId != null &&
                  selectedDate != null &&
                  selectedTimeFormatted != null) {
                // Implement your booking submission logic here
                print(
                  'Confirming booking for Specialist ID: $specialistId on ${selectedDate.toLocal()} at $selectedTimeFormatted',
                );

                onBookingClicked();
                // After successful booking, you might want to:
                // 1. Show a success message (Snackbar, Dialog).
                // 2. Navigate to a confirmation screen or back to the home screen.
                Get.back(); // Close the bottom sheet
                // Optionally, navigate to a success screen: Get.toNamed(AppRoutes.bookingSuccess);
              } else {
                Get.snackbar(
                  'Error',
                  'Missing booking details. Please try again.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Confirm Booking', style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            Get.back(); // Close the bottom sheet
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    ),
  );
}
