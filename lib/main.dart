import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart'
    show GetMaterialApp;
import 'package:service_reservation_app/routes/app_routes.dart' show AppRoutes;
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
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.login, // Set initial route
      getPages: AppRoutes.pages, // Define your routes
    );
  }
}
