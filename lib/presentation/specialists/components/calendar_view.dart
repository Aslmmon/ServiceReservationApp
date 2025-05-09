import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../utils/appColors/AppColors.dart';

class CalendarView extends StatefulWidget {
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;

  const CalendarView({
    super.key,
    required this.focusedDay,
    required this.calendarFormat,
    this.selectedDay,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
  });

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.primaryPurple.withOpacity(0.1),
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime(DateTime.now().year + 1),
        focusedDay: widget.focusedDay,
        calendarFormat: widget.calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(widget.selectedDay, day);
        },
        onDaySelected: widget.onDaySelected,
        onFormatChanged: widget.onFormatChanged,
        onPageChanged: widget.onPageChanged,
        calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          selectedDecoration: BoxDecoration(
            color: AppColors.primaryPurple,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}