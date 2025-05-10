import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/repositories/appointment_repository.dart';
import '../models/appointment_model.dart' show Appointment;

class FirebaseAppointmentRepository implements AppointmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _appointmentsCollection = 'appointments';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> bookAppointment(
   Appointment appointment
  ) async {
    try {
      await _firestore
          .collection(_appointmentsCollection)
          .add(appointment.toFirestore());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Appointment>> getUserAppointments() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore
            .collection(_appointmentsCollection)
            .where('userId', isEqualTo: _auth.currentUser?.uid)
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
      rethrow;
    }
  }
}
