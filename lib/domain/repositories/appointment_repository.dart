import 'package:service_reservation_app/data/models/appointment_model.dart'
    show Appointment;

abstract class AppointmentRepository {
  Future<void> bookAppointment(
    String userId,
    String specialistId,
    DateTime dateTime,
  );

  Future<List<Appointment>> getUserAppointments();

  Future<void> cancelAppointment(String appointmentId);
}
