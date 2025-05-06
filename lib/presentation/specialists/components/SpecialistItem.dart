import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/presentation/auth/auth_controller.dart';
import 'package:service_reservation_app/presentation/specialists/specialists_controller.dart';
import 'package:service_reservation_app/routes/app_routes.dart';

import '../../../data/models/specialist_model.dart';
import '../../../utils/appColors/AppColors.dart';
import '../../../utils/appStrings/AppStrings.dart';
import '../../../utils/appTextStyle/AppTextStyles.dart';

class SpecialistGridItem extends StatelessWidget {
  final Specialist specialist;

  const SpecialistGridItem({Key? key, required this.specialist})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final specialistController = Get.find<SpecialistController>();
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: () => specialistController.getSpecialistDetails(specialist.id),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: AppColors.primaryPurple,
                ), // Replace with actual image if available
              ),
              const SizedBox(height: 8.0),
              Text(
                specialist.name,
                style: AppTextStyles.label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4.0),
              Text(
                specialist.specialization,
                style: AppTextStyles.label.copyWith(color: AppColors.lightText),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                onPressed: () {
                  // print('${AppStrings.bookButtonTapped} ${specialist.name}');
                  // authController
                  //     .logout(); // Keep this for now, adjust as needed
                  Get.toNamed(AppRoutes.booking, arguments: specialist);
                },
                child: Text(AppStrings.book),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
