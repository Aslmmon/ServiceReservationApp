import 'package:get/get.dart';
import 'package:service_reservation_app/data/data_source/firebase_user_data_source.dart'
    show FirebaseUserRepository;
import '../../../data/data_source/firebase_appointment_data_source.dart' show FirebaseAppointmentRepository;
import '../../../domain/repositories/appointment_repository.dart';
import '../../../domain/use_cases/appointment/CancelAppointmentUseCase.dart'
    show CancelAppointmentUseCase;
import '../../../domain/use_cases/booking/get_user_appointments_use_case.dart'
    show GetUserAppointmentsUseCase;
import '../controllers/my_appointments_controller.dart';

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
    Get.lazyPut(
      () => FirebaseUserRepository(),
    ); // Make sure UserRepository is available
  }
}
