import '../../repositories/appointment_repository.dart';

class CancelAppointmentUseCase {
  final AppointmentRepository appointmentRepository;

  CancelAppointmentUseCase({required this.appointmentRepository});

  Future<void> execute(String appointmentId) async {
    await appointmentRepository.cancelAppointment(appointmentId);
  }
}