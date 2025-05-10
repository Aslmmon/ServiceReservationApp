import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TimeOfDay? convertStringToTimeOfDay(String timeStr) {
  try {
    final format = DateFormat('HH:mm'); // Use 24-hour format
    final parsedTime = format.parse(timeStr);
    return TimeOfDay(hour: parsedTime.hour, minute: parsedTime.minute);
  } catch (e) {
    return null;
  }
}

extension DateTimeExtension on DateTime {
  String formatDate() {
    return DateFormat('EEEE, MMMM d, y').format(this);
  }

  String formatTime() {
    return DateFormat('h:mm a').format(this);
  }
}