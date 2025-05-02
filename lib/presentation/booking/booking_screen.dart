import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:service_reservation_app/presentation/booking/confimationBottomSheet.dart'
    show buildConfirmationBottomSheet;
import 'package:table_calendar/table_calendar.dart';
import '../../data/models/specialist_model.dart';
import '../../routes/app_routes.dart';
import '../auth/controllers/booking_controller.dart'; // For navigation

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

  TimeOfDay? _convertToTimeOfDay(String timeStr) {
    try {
      final format = DateFormat('HH:mm'); // Use 24-hour format
      final parsedTime = format.parse(timeStr);
      return TimeOfDay(hour: parsedTime.hour, minute: parsedTime.minute);
    } catch (e) {
      print('Error parsing time string: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.back_hand),
          onPressed: () => Get.back(),
        ), // This is usually the default
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book with ${_specialist?.name ?? "Loading..."}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TableCalendar(
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
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Time:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _selectedDay == null
                ? const Text('Please select a date first.')
                : _availableTimesForSelectedDate.isEmpty
                ? const Text('No available times for the selected date.')
                : Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children:
                      _availableTimesForSelectedDate.map((timeStr) {
                        return ChoiceChip(
                          label: Text(timeStr),
                          selected:
                              _selectedTime?.format(context) ==
                              _convertToTimeOfDay(timeStr)?.format(context),
                          onSelected: (isSelected) {
                            final timeOfDay = _convertToTimeOfDay(timeStr);
                            if (isSelected && timeOfDay != null) {
                              setState(() {
                                _selectedTime = timeOfDay;
                              });
                            } else {
                              setState(() {
                                _selectedTime = null;
                              });
                            }
                          },
                        );
                      }).toList(),
                ),
            const SizedBox(height: 20),
            if (_selectedTime != null)
              Text('Selected Time: ${_selectedTime!.format(context)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _selectedDay == null ||
                          _selectedTime == null ||
                          _specialist == null
                      ? null
                      : () {
                        print(
                          'Selected Date: $_selectedDay, Time: $_selectedTime, Specialist: ${_specialist!.name}',
                        );
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          // Allows the bottom sheet to take more height if needed
                          builder: (BuildContext bc) {
                            return buildConfirmationBottomSheet(
                              context,
                              _specialist?.name,
                              _selectedDay,
                              _selectedTime?.format(context),
                              _specialist?.id,
                              () {
                                bookingController.bookAppointment(
                                  _specialist!.id,
                                  "test",
                                  context,
                                );
                              },
                            );
                          },
                        );
                      },
              child: const Text('Next: Review and Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
