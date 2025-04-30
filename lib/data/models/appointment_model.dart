import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_reservation_app/presentation/entities/appointment_status.dart'
    show AppointmentStatus;

class Appointment {
  final String id;
  final String userId;
  final String specialistId;
  final DateTime dateTime;
  final AppointmentStatus status;

  Appointment({
    required this.id,
    required this.userId,
    required this.specialistId,
    required this.dateTime,
    required this.status,
  });

  factory Appointment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final timestamp = data?['dateTime'] as Timestamp?;
    final statusString = data?['status'] as String?;
    AppointmentStatus parsedStatus = AppointmentStatus.booked;

    if (statusString != null) {
      parsedStatus = AppointmentStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == statusString.toLowerCase(),
        orElse: () => AppointmentStatus.booked,
      );
    }

    return Appointment(
      id: doc.id,
      userId: data?['userId'] as String? ?? '',
      specialistId: data?['specialistId'] as String? ?? '',
      dateTime: timestamp?.toDate() ?? DateTime.now(),
      status: parsedStatus,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'specialistId': specialistId,
      'dateTime': Timestamp.fromDate(dateTime),
      'status': status.name.toLowerCase(),
    };
  }
}
