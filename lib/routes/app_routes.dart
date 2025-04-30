import 'package:get/get.dart';
import 'package:service_reservation_app/presentation/auth/bindings/auth_binding.dart'
    show AuthBinding;
import 'package:service_reservation_app/presentation/auth/login_screen.dart'
    show LoginScreen;
import 'package:service_reservation_app/presentation/auth/register_screen.dart'
    show RegisterScreen;

// import '../specialist/bindings/specialist_binding.dart';
// import '../specialist/screens/specialist_list_screen.dart';
// import '../specialist/screens/specialist_detail_screen.dart';
// import '../booking/bindings/booking_binding.dart';
// import '../booking/screens/booking_screen.dart';
// import '../appointment/bindings/appointment_binding.dart';
// import '../appointment/screens/my_appointments_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const specialistList = '/specialists';
  static const specialistDetail = '/specialist_detail';
  static const booking = '/booking';
  static const myAppointments = '/my_appointments';

  static final pages = [
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    // GetPage(
    //   name: specialistList,
    //   page: () => const SpecialistListScreen(),
    //   binding: SpecialistBinding(),
    // ),
    // GetPage(
    //   name: specialistDetail,
    //   page: () => const SpecialistDetailScreen(),
    //   binding: SpecialistBinding(),
    // ),
    // GetPage(
    //   name: booking,
    //   page: () => const BookingScreen(),
    //   binding: BookingBinding(),
    // ),
    // GetPage(
    //   name: myAppointments,
    //   page: () => const MyAppointmentsScreen(),
    //   binding: AppointmentBinding(),
    // ),
  ];
}
