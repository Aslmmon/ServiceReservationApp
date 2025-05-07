import 'package:flutter/material.dart';
import 'package:service_reservation_app/utils/appStrings/AppStrings.dart';

class AvailableTimesWidget extends StatelessWidget {
  final Map<String, List<dynamic>> availableTimes;

  const AvailableTimesWidget({super.key, required this.availableTimes});

  @override
  Widget build(BuildContext context) {
    if (availableTimes.isEmpty) {
      return const Text('No available times.');
    }

    List<Widget> children = [];
    availableTimes.forEach((day, times) {
      children.add(
        Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
      );

      if (times.isNotEmpty) {
        for (var time in times) {
          children.add(
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const Text('• '), Expanded(child: Text(time))],
            ),
          );
        }
      } else {
        children.add(const Text('No times available on this day.'));
      }
      children.add(const SizedBox(height: 8.0));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
