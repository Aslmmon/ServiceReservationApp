import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_reservation_app/presentation/bindings/auth_binding.dart';
import 'package:service_reservation_app/routes/app_navigation.dart';
import 'package:service_reservation_app/routes/app_routes.dart' show AppRoutes;
import 'package:service_reservation_app/utils/appColors/AppColors.dart';
import 'package:service_reservation_app/utils/appStrings/AppStrings.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(() async => AppNavigation());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      theme: ThemeData(
        primaryColor: AppColors.primaryPurple,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          scrolledUnderElevation: 0.0,


        ),
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: AppColors.primaryPurple,
        ),
        textTheme: GoogleFonts.montserratTextTheme(
          ThemeData.light()
              .textTheme, // Use the default light theme's textTheme as a base
        ),
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
    );
  }
}
