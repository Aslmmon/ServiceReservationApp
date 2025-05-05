import 'package:get/get.dart';
import '../../../data/data_source/firebase_appointment_data_source.dart'
    show FirebaseAppointmentRepository;
import '../../../domain/repositories/appointment_repository.dart';
import '../../../domain/use_cases/appointment/CancelAppointmentUseCase.dart'
    show CancelAppointmentUseCase;
import '../../domain/use_cases/appointment/GetUserAppointmentsUseCase.dart';
import '../appointments/appointments_controller.dart';

class AppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentRepository>(() => FirebaseAppointmentRepository());
    Get.lazyPut(
      () => GetUserAppointmentsUseCase(appointmentRepository: Get.find()),
    );
    Get.lazyPut(
      () => CancelAppointmentUseCase(appointmentRepository: Get.find()),
    );
    Get.lazyPut(() => MyAppointmentsController());
  }
}
