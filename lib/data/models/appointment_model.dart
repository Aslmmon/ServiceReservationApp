import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_reservation_app/domain/entities/appointment_status.dart'
    show AppointmentStatus;

class Appointment {
  final String? id;
  final String? userId;
  final String? specialistId;
  final String? date;
  final String? time;

  final AppointmentStatus? status;

  Appointment({
    this.id,
    this.userId,
    required this.specialistId,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Appointment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
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
      date: data?['date'] as String? ?? '',
      time: data?['time'] as String? ?? '',
      status: parsedStatus,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'specialistId': specialistId,
      'date': date,
      'time': time,
      'status': status?.name.toLowerCase(),
    };
  }
}
