import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/repositories/appointment_repository.dart';
import '../../../domain/entities/appointment_status.dart';
import '../models/appointment_model.dart' show Appointment;

class FirebaseAppointmentRepository implements AppointmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _appointmentsCollection = 'appointments';

  @override
  Future<void> bookAppointment(
    String userId,
    String specialistId,
    DateTime dateTime,
  ) async {
    try {
      final Appointment appointment = Appointment(
        id: '',
        // Firestore will auto-generate an ID
        userId: userId,
        specialistId: specialistId,
        dateTime: dateTime,
        status: AppointmentStatus.booked,
      );
      await _firestore
          .collection(_appointmentsCollection)
          .add(appointment.toFirestore());
    } catch (e) {
      print('Error booking appointment: $e');
      rethrow;
    }
  }

  @override
  Future<List<Appointment>> getUserAppointments(String userId) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore
            .collection(_appointmentsCollection)
            .where('userId', isEqualTo: userId)
            .get();
    return snapshot.docs.map((doc) => Appointment.fromFirestore(doc)).toList();
  }

  @override
  Future<void> cancelAppointment(String appointmentId) async {
    try {
      await _firestore
          .collection(_appointmentsCollection)
          .doc(appointmentId)
          .delete();
    } catch (e) {
      print('Error cancelling appointment: $e');
      rethrow;
    }
  }
}
