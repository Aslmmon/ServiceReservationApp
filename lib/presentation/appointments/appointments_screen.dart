import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/presentation/appointments/appointments_controller.dart';
import 'package:service_reservation_app/utils/components/AppButton.dart';
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
              style: AppTextStyles.heading,
            ),
            const SizedBox(height: 8),
            Text(
              '${AppStrings.appointmentDate} ${appointment.date}',
              style: AppTextStyles.subHeading,
            ),
            Text(
              '${AppStrings.appointmentTime} ${appointment.time}',
              style: AppTextStyles.subHeading,
            ),
            const SizedBox(height: 16),
            ReusableButton(
              text: AppStrings.cancel,
              onPressed: () => _showCancelConfirmationDialog(appointment.id!),
            ),
          ],
        ),
      ),
    );
  }

  _showCancelConfirmationDialog(String appointmentId) {
    RxBool isCancellingDialog = false.obs; // Local RxBool for this dialog
    return Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        title: const Text(AppStrings.cancelAppointmentAlertDialogTitle),
        content: const Text(AppStrings.cancelAppointmentAlertDialogTitle),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(AppStrings.noTitle),
          ),
          Obx(() {
            final isCurrentlyCancelling =
                controller.isCancelling[appointmentId]?.value ?? false;
            return isCurrentlyCancelling
                ? const CircularProgressIndicator()
                : GestureDetector(
                  onTap: ()  async {
                    if (!isCancellingDialog.value) {
                      isCancellingDialog.value = true; // Prevent multiple taps on this dialog
                      Get.back(); // Close the dialog immediately
                      await Future.delayed(const Duration(milliseconds: 300)); // Small delay to ensure dialog is closed
                      await controller.cancelAppointment(appointmentId);
                      isCancellingDialog.value = false;
                    }
                  } ,
                  child: Text(AppStrings.cancelAppointmentAlertDialogYesTitle),
                );
          }),
        ],
      ),
    );
  }
}
