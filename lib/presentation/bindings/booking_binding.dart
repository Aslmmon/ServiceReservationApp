import 'package:get/get.dart';
import '../../../data/data_source/firebase_appointment_data_source.dart'
    show FirebaseAppointmentRepository;
import '../../../domain/repositories/appointment_repository.dart';
import '../../../domain/use_cases/booking/book_appointment_use_case.dart';
import '../../domain/use_cases/auth/get_current_user_use_case.dart';
import '../booking/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentRepository>(() => FirebaseAppointmentRepository());
    Get.lazyPut(
      () => BookAppointmentUseCase(appointmentRepository: Get.find()),
    );
    Get.lazyPut(() => BookingController());
    Get.lazyPut(() => GetCurrentUserUseCase(userRepository: Get.find()));
  }
}
