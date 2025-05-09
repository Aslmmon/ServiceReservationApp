// lib/presentation/booking/components/time_selection_view.dart
import 'package:flutter/material.dart';
import '../../../utils/appColors/AppColors.dart';
import '../../../utils/appStrings/AppStrings.dart';
import '../../../utils/appTextStyle/AppTextStyles.dart';
import '../../../utils/components/AvailableChips.dart';
import '../../../utils/utils.dart'; // Assuming you have this helper

class TimeSelectionView extends StatelessWidget {
  final DateTime? selectedDay;
  final List<String> availableTimesForSelectedDate;
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay?) onTimeSelected;

  const TimeSelectionView({
    super.key,
    this.selectedDay,
    required this.availableTimesForSelectedDate,
    this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedDay == null) {
      return Text(
        AppStrings.pleaseSelectDateFirst,
        style: AppTextStyles.label.copyWith(color: AppColors.lightText),
      );
    } else if (availableTimesForSelectedDate.isEmpty) {
      return Text(
        AppStrings.noAvailableTimes,
        style: AppTextStyles.label.copyWith(color: AppColors.darkText),
      );
    } else {
      return AvailableTimeChips(
        availableTimes: availableTimesForSelectedDate,
        selectedTime: selectedTime,
        onTimeSelected: (timeStr) {
          final timeOfDay = convertStringToTimeOfDay(timeStr);
          onTimeSelected(timeOfDay);
        },
      );
    }
  }
}