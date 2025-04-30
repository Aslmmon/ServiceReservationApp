import '../../repositories/appointment_repository.dart';

class BookAppointmentUseCase {
  final AppointmentRepository appointmentRepository;

  BookAppointmentUseCase({required this.appointmentRepository});

  Future<void> execute(String userId, String specialistId, DateTime dateTime) async {
    await appointmentRepository.bookAppointment(userId, specialistId, dateTime);
  }
}