import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TimeOfDay? convertStringToTimeOfDay(String timeStr) {
  try {
    final format = DateFormat('HH:mm'); // Use 24-hour format
    final parsedTime = format.parse(timeStr);
    return TimeOfDay(hour: parsedTime.hour, minute: parsedTime.minute);
  } catch (e) {
    print('Error parsing time string: $e');
    return null;
  }
}
