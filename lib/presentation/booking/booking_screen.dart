import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:service_reservation_app/data/models/specialist_model.dart';
import 'package:service_reservation_app/presentation/booking/booking_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/appColors/AppColors.dart';
import '../../utils/appStrings/AppStrings.dart';
import '../../utils/appTextStyle/AppTextStyles.dart';
import '../../utils/components/AppButton.dart';
import '../../utils/components/AvailableChips.dart';
import '../../utils/utils.dart';
import 'confimationBottomSheet.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingController bookingController = Get.find();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;
  List<String> _availableTimesForSelectedDate = [];
  Specialist? _specialist;

  @override
  void initState() {
    super.initState();
    _specialist = Get.arguments as Specialist?;
    _updateAvailableTimes();
  }

  @override
  void didUpdateWidget(covariant BookingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAvailableTimes();
  }

  void _updateAvailableTimes() {
    if (_selectedDay != null && _specialist != null) {
      final dayOfWeek = DateFormat('EEEE').format(_selectedDay!).toLowerCase();
      setState(() {
        _availableTimesForSelectedDate =
            _specialist!.availableDays.containsKey(dayOfWeek.capitalize)
                ? (_specialist!.availableDays[dayOfWeek.capitalize]
                        as List<dynamic>)
                    .cast<String>()
                    .toList()
                : [];
        _selectedTime = null; // Reset selected time when date changes
      });
    } else {
      setState(() {
        _availableTimesForSelectedDate = [];
        _selectedTime = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.bookAppointment),
        leading: IconButton(
          icon: const Icon(
            size: 15,
            Icons.arrow_back_ios_new,
            color: AppColors.darkText,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppStrings.bookWithSpecialist} ${_specialist?.name ?? AppStrings.loading}',
              style: AppTextStyles.heading.copyWith(
                color: AppColors.primaryPurple,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.selectDate,
              style: AppTextStyles.subHeading.copyWith(
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 10),
            _buildCalendar(),
            const SizedBox(height: 20),
            Text(
              AppStrings.selectTime,
              style: AppTextStyles.label.copyWith(color: AppColors.darkText),
            ),
            const SizedBox(height: 10),
            _buildTimeSelection(),
            const SizedBox(height: 24),
            if (_selectedTime != null)
              Text(
                '${AppStrings.selectedTime} ${_selectedTime!.format(context)}',
                style: AppTextStyles.label.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildNextButton(),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.primaryPurple.withOpacity(0.1),
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime(DateTime.now().year + 1),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            _updateAvailableTimes();
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
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

  Widget _buildTimeSelection() {
    if (_selectedDay == null) {
      return Text(
        AppStrings.pleaseSelectDateFirst,
        style: AppTextStyles.label.copyWith(color: AppColors.lightText),
      );
    } else if (_availableTimesForSelectedDate.isEmpty) {
      return Text(
        AppStrings.noAvailableTimes,
        style: AppTextStyles.label.copyWith(color: AppColors.darkText),
      );
    } else {
      return AvailableTimeChips(
        availableTimes: _availableTimesForSelectedDate,
        selectedTime: _selectedTime,
        onTimeSelected: (timeStr) {
          final timeOfDay = convertStringToTimeOfDay(timeStr);
          setState(() {
            _selectedTime = timeOfDay;
          });
        },
      );
    }
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      child: ReusableButton(
        text: AppStrings.nextReviewConfirm,
        onPressed: () {
          _selectedDay == null || _selectedTime == null || _specialist == null
              ? null
              : showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext bc) {
                  return buildConfirmationBottomSheet(
                    context,
                    _specialist?.name,
                    _selectedDay,
                    _selectedTime?.format(context),
                    _specialist?.id,
                    (appointment) {
                      bookingController.bookAppointment(
                        appointment.specialistId,
                        appointment.userId,
                        appointment.dateTime,
                      );
                    },
                  );
                },
              );
        },
      ),
    );
  }
}
