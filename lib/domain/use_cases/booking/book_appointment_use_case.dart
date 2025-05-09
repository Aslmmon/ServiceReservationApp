import 'package:service_reservation_app/data/models/appointment_model.dart';

import '../../repositories/appointment_repository.dart';

class BookAppointmentUseCase {
  final AppointmentRepository appointmentRepository;

  BookAppointmentUseCase({required this.appointmentRepository});

  Future<void> execute(Appointment appointment) async {
    await appointmentRepository.bookAppointment(appointment);
  }
}
