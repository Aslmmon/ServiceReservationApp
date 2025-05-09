import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:service_reservation_app/data/models/specialist_model.dart';
import 'package:service_reservation_app/presentation/booking/booking_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/appColors/AppColors.dart';
import '../../utils/appStrings/AppStrings.dart';
import '../../utils/appTextStyle/AppTextStyles.dart';
import '../specialists/components/calendar_view.dart';
import '../specialists/components/next_button_view.dart';
import '../specialists/components/time_selection_view.dart';

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
        title: Text(AppStrings.bookAppointment.tr),
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
            _buildSpecialistInfo(),
            const SizedBox(height: 24),
            _buildDateSelection(),
            const SizedBox(height: 20),
            _buildTimeLabel(),
            const SizedBox(height: 10),
            _buildTimeSelectionView(),
            const SizedBox(height: 24),
            _buildSelectedTimeDisplay(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NextButtonView(
          specialist: _specialist,
          selectedDay: _selectedDay,
          selectedTime: _selectedTime,
        ),
      ),
    );
  }

  Widget _buildSpecialistInfo() {
    return Text(
      '${AppStrings.bookWithSpecialist.tr} ${_specialist?.name ?? AppStrings.loading.tr}',
      style: AppTextStyles.heading.copyWith(color: AppColors.primaryPurple),
    );
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.selectDate.tr,
          style: AppTextStyles.subHeading.copyWith(color: AppColors.darkText),
        ),
        const SizedBox(height: 10),
        CalendarView(
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDay: _selectedDay,
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedTime = null; // Reset time on date change
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
        ),
      ],
    );
  }

  Widget _buildTimeLabel() {
    return Text(
      AppStrings.selectTime.tr,
      style: AppTextStyles.label.copyWith(color: AppColors.darkText),
    );
  }

  Widget _buildTimeSelectionView() {
    return TimeSelectionView(
      selectedDay: _selectedDay,
      availableTimesForSelectedDate: _availableTimesForSelectedDate,
      selectedTime: _selectedTime,
      onTimeSelected: (timeOfDay) {
        setState(() {
          _selectedTime = timeOfDay;
        });
      },
    );
  }

  Widget _buildSelectedTimeDisplay() {
    return _selectedTime != null
        ? Text(
          '${AppStrings.selectedTime.tr} ${_selectedTime!.format(context)}',
          style: AppTextStyles.label.copyWith(fontWeight: FontWeight.bold),
        )
        : const SizedBox.shrink();
  }
}
