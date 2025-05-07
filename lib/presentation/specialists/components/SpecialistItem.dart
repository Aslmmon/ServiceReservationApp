import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/routes/app_routes.dart';
import 'package:service_reservation_app/utils/components/AppButton.dart';

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
    return Card(
      color: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: GestureDetector(
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
              ReusableButton(
                text: AppStrings.book,
                onPressed:
                    () => Get.toNamed(AppRoutes.booking, arguments: specialist),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
