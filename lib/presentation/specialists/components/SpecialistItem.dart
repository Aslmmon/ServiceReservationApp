import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:service_reservation_app/presentation/specialists/components/AvailableTime.dart';
import 'package:service_reservation_app/utils/appAssets/AppAssets.dart';

import '../../../data/models/specialist_model.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/appColors/AppColors.dart';
import '../../../utils/appStrings/AppStrings.dart';
import '../../../utils/appTextStyle/AppTextStyles.dart';
import '../../../utils/components/AppButton.dart';

class SpecialistItem extends StatelessWidget {
  final Specialist specialist;

  const SpecialistItem({Key? key, required this.specialist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(specialist.availableDays.toString());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AppAssets.placeholderImage,
                height: 120,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    specialist.name,
                    style: AppTextStyles.heading,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    specialist.specialization,
                    style: AppTextStyles.subHeading.copyWith(
                      color: AppColors.lightText,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    specialist.bio.toString(),
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.lightText,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AvailableTimesWidget(
                    availableTimes: specialist.availableDays,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        ReusableButton(
          text: AppStrings.book,
          height: 35,
          onPressed:
              () => Get.toNamed(AppRoutes.booking, arguments: specialist),
        ),
      ],
    );
  }
}
