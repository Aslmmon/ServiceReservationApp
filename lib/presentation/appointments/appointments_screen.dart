import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:service_reservation_app/presentation/appointments/appointments_controller.dart';
import 'package:service_reservation_app/utils/components/AppButton.dart';
import 'package:service_reservation_app/utils/utils.dart';
import '../../data/models/appointment_model.dart';
import '../../utils/appColors/AppColors.dart';
import '../../utils/appStrings/AppStrings.dart';
import '../../utils/appTextStyle/AppTextStyles.dart';

class MyAppointmentsScreen extends GetView<MyAppointmentsController> {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.myAppointments), centerTitle: true),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            await controller.fetchUserAppointments();
          },
          color: AppColors.primaryPurple,
          child: _buildAppointmentList(),
        ),
      ),
    );
  }

  Widget _buildAppointmentList() {
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryPurple),
      );
    } else if (controller.errorMessage.value.isNotEmpty) {
      return Center(
        child: Text(
          '${AppStrings.error}: ${controller.errorMessage.value}',
          style: TextStyle(color: AppColors.primaryPurple),
        ),
      );
    } else if (controller.appointments.isEmpty) {
      return const Center(
        child: Text(AppStrings.noAppointments, style: TextStyle(fontSize: 16)),
      );
    } else {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.appointments.length,
        itemBuilder: (context, index) {
          final appointment = controller.appointments[index];
          return _buildAppointmentItem(appointment);
        },
      );
    }
  }

  Widget _buildAppointmentItem(Appointment appointment) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppStrings.appointmentId} ${appointment.id}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: 8),
            Text(
              '${AppStrings.appointmentDate} ${appointment.dateTime.formatDate()}',
              style: AppTextStyles.label,
            ),
            Text(
              '${AppStrings.appointmentTime} ${appointment.dateTime.formatTime()}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: 16),
            ReusableButton(
              text: AppStrings.cancel,
              onPressed: () {
                _showCancelConfirmationDialog(
                  appointment.id,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCancelConfirmationDialog(String appointmentId) async {
    return Get.dialog(
      AlertDialog(
        title: const Text('Cancel Appointment?'),
        content: const Text(
          'Are you sure you want to cancel this appointment?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('No')),
          TextButton(
            onPressed: () {
              controller.cancelAppointment(appointmentId);
              Get.back();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.darkText),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}
