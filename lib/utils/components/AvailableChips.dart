import 'package:flutter/material.dart';
import '../appColors/AppColors.dart';
import '../utils.dart';

class AvailableTimeChips extends StatelessWidget {
  final List<String> availableTimes;
  final TimeOfDay? selectedTime;
  final ValueChanged<String> onTimeSelected;

  const AvailableTimeChips({
    Key? key,
    required this.availableTimes,
    this.selectedTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children:
          availableTimes.map((timeStr) {
            final timeOfDay = convertStringToTimeOfDay(timeStr);
            final isSelected =
                selectedTime?.format(context) == timeOfDay?.format(context);

            return ChoiceChip(
              label: Text(
                timeStr,
                style: TextStyle(
                  color: isSelected ? AppColors.lightGrey :  AppColors.darkText,
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.primaryPurple,
              backgroundColor: AppColors.lightGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              checkmarkColor: AppColors.lightGrey,
              side: BorderSide(color: AppColors.lightGrey),
              onSelected: (isSelected) {
                if (timeOfDay != null) {
                  onTimeSelected(timeStr);
                }
              },
            );
          }).toList(),
    );
  }
}
