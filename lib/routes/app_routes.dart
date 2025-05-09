import 'package:get/get.dart';
import 'package:service_reservation_app/data/models/specialist_model.dart'
    show Specialist;
import 'package:service_reservation_app/presentation/auth/login_screen.dart'
    show LoginScreen;
import 'package:service_reservation_app/presentation/auth/register_screen.dart'
    show RegisterScreen;
import 'package:service_reservation_app/presentation/home/HomeScreen.dart';
import 'package:service_reservation_app/presentation/splash/SplashScreen.dart';
import '../presentation/appointments/appointments_screen.dart'
    show MyAppointmentsScreen;

import '../presentation/bindings/appointment_binding.dart';
import '../presentation/bindings/auth_binding.dart';
import '../presentation/bindings/booking_binding.dart';
import '../presentation/bindings/specialist_binding.dart';
import '../presentation/booking/booking_screen.dart' show BookingScreen;
import '../presentation/specialists/specialist_list_screen.dart'
    show SpecialistListScreen;

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const specialistList = '/specialists';
  static const booking = '/booking';
  static const myAppointments = '/my_appointments';
  static const home = '/home';
  static const splash = '/'; // Set loading as the root route

  static final pages = [
    GetPage(name: splash, page: () => const Splashscreen()),
    GetPage(name: login, page: () => LoginScreen(), binding: AuthBinding()),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: specialistList,
      page: () => const SpecialistListScreen(),
      binding: SpecialistBinding(),
    ),
    GetPage(
      name: booking,
      page: () => BookingScreen(),
      binding: BookingBinding(),
      arguments: Specialist,
    ),
    GetPage(
      name: myAppointments,
      page: () => const MyAppointmentsScreen(),
      binding: AppointmentBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      bindings: [SpecialistBinding(), AppointmentBinding()],
    ),
  ];
}
