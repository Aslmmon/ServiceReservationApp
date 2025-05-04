import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../appColors/AppColors.dart';

class AppTextStyles {
  static TextStyle heading = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );
  static TextStyle subHeading = GoogleFonts.montserrat(
    fontSize: 16,
    color: AppColors.primaryPurple,
  );
  static TextStyle label = GoogleFonts.montserrat(
    fontSize: 14,
    color: AppColors.lightText,
  );
  static TextStyle buttonText = GoogleFonts.montserrat(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle linkText = GoogleFonts.montserrat(
    fontSize: 14,
    color: AppColors.primaryPurple,
    fontWeight: FontWeight.w500,
  );
}
