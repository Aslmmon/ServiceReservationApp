import 'package:service_reservation_app/data/models/appointment_model.dart';

import '../../repositories/appointment_repository.dart';

class GetUserAppointmentsUseCase {
  final AppointmentRepository appointmentRepository;

  GetUserAppointmentsUseCase({required this.appointmentRepository});

  Future<List<Appointment>> execute(String userId) async {
    return await appointmentRepository.getUserAppointments(userId);
  }
}