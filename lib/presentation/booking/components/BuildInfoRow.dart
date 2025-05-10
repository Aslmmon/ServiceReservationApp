import 'package:flutter/material.dart';
import '../../../utils/appColors/AppColors.dart';
import '../../../utils/appTextStyle/AppTextStyles.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.subHeading.copyWith(color: AppColors.darkText),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.subHeading.copyWith(
                color: AppColors.primaryPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
