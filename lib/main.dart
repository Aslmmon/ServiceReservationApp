import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart'
    show GetMaterialApp;
import 'package:google_fonts/google_fonts.dart';
import 'package:service_reservation_app/routes/app_routes.dart' show AppRoutes;
import 'package:service_reservation_app/utils/appColors/AppColors.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Service Reservation App',
      theme: ThemeData(
        primaryColor: AppColors.primaryPurple,
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: AppColors.primaryPurple,
        ),
        textTheme: GoogleFonts.montserratTextTheme(
          ThemeData.light()
              .textTheme, // Use the default light theme's textTheme as a base
        ),
      ),
      initialRoute: AppRoutes.login, // Set initial route
      getPages: AppRoutes.pages, // Define your routes
    );
  }
}
