import 'package:get/get.dart';
import 'package:service_reservation_app/data/models/specialist_model.dart'
    show Specialist;
import 'package:service_reservation_app/presentation/auth/bindings/auth_binding.dart'
    show AuthBinding;
import 'package:service_reservation_app/presentation/auth/login_screen.dart'
    show LoginScreen;
import 'package:service_reservation_app/presentation/auth/register_screen.dart'
    show RegisterScreen;
import 'package:service_reservation_app/presentation/home/HomeScreen.dart';
import 'package:service_reservation_app/presentation/splash/SplashScreen.dart';
import '../main.dart';
import '../presentation/appointments/my_appointments_screen.dart'
    show MyAppointmentsScreen;
import '../presentation/auth/bindings/appointment_binding.dart'
    show AppointmentBinding;
import '../presentation/auth/bindings/booking_binding.dart' show BookingBinding;
import '../presentation/auth/bindings/specialist_binding.dart';
import '../presentation/booking/booking_screen.dart' show BookingScreen;
import '../presentation/specialists/specialist_detail_screen.dart'
    show SpecialistDetailScreen;
import '../presentation/specialists/specialist_list_screen.dart'
    show SpecialistListScreen;

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const specialistList = '/specialists';
  static const specialistDetail = '/specialist_detail';
  static const booking = '/booking';
  static const myAppointments = '/my_appointments';
  static const home = '/home';
  static const splash = '/'; // Set loading as the root route

  static final pages = [
    GetPage(name: splash, page: () => const Splashscreen()),
    // Add the loading screen route
    GetPage(name: login, page: () => LoginScreen(),
        // binding: AuthBinding()
    ),
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
      name: specialistDetail,
      page: () => const SpecialistDetailScreen(),
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
      binding: SpecialistBinding(),
    ),
  ];
}
