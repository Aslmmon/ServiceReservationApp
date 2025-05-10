import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:service_reservation_app/data/data_source/fb_collections.dart';
import 'package:service_reservation_app/utils/utils.dart';
import '../../../domain/repositories/appointment_repository.dart';
import '../models/appointment_model.dart' show Appointment;
import 'package:intl/intl.dart';

class FirebaseAppointmentRepository implements AppointmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> bookAppointment(Appointment appointment) async {
    final specialistRef = _firestore
        .collection(specialistsCollection)
        .doc(appointment.specialistId);
    try {
      await _firestore.runTransaction((transaction) async {
        final specialistSnapshot = await transaction.get(specialistRef);
        final specialistData = specialistSnapshot.data();

        if (specialistData != null &&
            specialistData.containsKey('availableDays')) {
          final availableDays =
              specialistData['availableDays'] as Map<String, dynamic>;

          final appointmentDay = _getDayOfWeek(appointment.date, AppDateFormat);
          final formattedTime = _formatTime(appointment.time);

          if (availableDays.containsKey(appointmentDay) &&
              availableDays[appointmentDay] is List) {
            final availableTimes =
                (availableDays[appointmentDay] as List<dynamic>).cast<String>();

            if (availableTimes.contains(formattedTime)) {
              // Remove the booked time slot
              transaction.update(specialistRef, {
                'availableDays.$appointmentDay': FieldValue.arrayRemove([
                  formattedTime,
                ]),
              });
              await _firestore
                  .collection(appointmentsCollection)
                  .add(appointment.toFirestore());
            } else {
              throw Exception('The selected time slot is no longer available.');
            }
          } else {
            throw Exception('No availability found for the selected day.');
          }
        } else {
          throw Exception('Specialist availability data not found.');
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Appointment>> getUserAppointments() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore
            .collection(appointmentsCollection)
            .where('userId', isEqualTo: _auth.currentUser?.uid)
            .get();
    return snapshot.docs.map((doc) => Appointment.fromFirestore(doc)).toList();
  }

  Future<void> cancelAppointment(String appointmentId) async {
    try {
      final appointmentDocRef = _firestore
          .collection(appointmentsCollection)
          .doc(appointmentId);
      final appointmentDoc = await appointmentDocRef.get();

      if (!appointmentDoc.exists) {
        debugPrint('Appointment document not found: $appointmentId');
        return; // Early return if appointment doesn't exist
      }

      final appointmentData = appointmentDoc.data()!;
      final specialistId = appointmentData['specialistId'] as String?;
      final date = appointmentData['date'] as String?;
      final time = appointmentData['time'] as String?;

      if (specialistId == null || date == null || time == null) {
        print(
          'Could not retrieve specialistId, date, or time for appointment: $appointmentId',
        );
        await appointmentDocRef
            .delete(); // Clean up potentially incomplete appointment
        return; // Early return after cleanup
      }

      final specialistRef = _firestore
          .collection(specialistsCollection)
          .doc(specialistId);

      final appointmentDay = _getDayOfWeek(date, AppDateFormat);
      final formattedTime = _formatTime(time);

      await _firestore.runTransaction((transaction) async {
        final specialistSnapshot = await transaction.get(specialistRef);
        final specialistData = specialistSnapshot.data();

        if (specialistData != null &&
            specialistData.containsKey('availableDays')) {
          final availableDays =
              specialistData['availableDays'] as Map<String, dynamic>;

          if (availableDays.containsKey(appointmentDay) &&
              availableDays[appointmentDay] is List) {
            transaction.update(specialistRef, {
              'availableDays.$appointmentDay': FieldValue.arrayUnion([
                formattedTime,
              ]),
            });
          } else {
            debugPrint(
              'Day not found in availability during cancellation: $appointmentDay',
            );
          }
        } else {
          debugPrint(
            'availableDays not found for specialist during cancellation: $specialistId',
          );
        }
        transaction.delete(appointmentDocRef);
      });
    } catch (e) {
      rethrow;
    }
  }

  String _getDayOfWeek(String? date, String? dateFormat) {
    try {
      print("date is ${date}");
      print("dateFormat is ${dateFormat}");

      DateTime appointmentDateTime = DateFormat(dateFormat).parse(date!);
      return DateFormat(
        'EEEE',
      ).format(appointmentDateTime).toLowerCase().capitalize!;
    } catch (e) {
      debugPrint("Error parsing date: $e"); // Important to log errors
      throw Exception('Invalid date format: $e'); // Throw exception with error
    }
  }
  String _formatTime(String? time) {
    try {
      print("time is ${time}");
      // print("dateFormat is ${dateFormat}");

      // Attempt to parse with AM/PM format first
      DateFormat inputFormatAMPM = DateFormat("h:mm a");
      DateTime dateTimeAMPM = inputFormatAMPM.parse(time!);
      DateFormat outputFormat = DateFormat(AppTimeFormat);
      return outputFormat.format(dateTimeAMPM);
    } catch (e) {
      try {
        // If AM/PM format fails, try parsing as 24-hour format directly
        DateFormat inputFormat24 = DateFormat(AppTimeFormat);
        DateTime dateTime24 = inputFormat24.parse(time!);
        return time; // No need to re-format if it's already 24-hour
      } catch (e) {
        // If both formats fail, throw the error
        print("Error formatting time: $e");
        throw Exception("Invalid time format: $e");
      }
    }
  }
}
