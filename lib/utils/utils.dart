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

const AppDateFormat = "EEEE, MMMM d, y";
const AppTimeFormat = "HH:mm";

extension DateTimeExtension on DateTime {
  String formatDate() {
    return DateFormat(AppDateFormat).format(this);
  }

  String formatTime() {
    return DateFormat('HH:mm').format(this);
  }
}
