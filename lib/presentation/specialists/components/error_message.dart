import 'package:flutter/material.dart';

import '../../../utils/appColors/AppColors.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message, // Ensure message is translatable
      style: const TextStyle(color: AppColors.darkText),
      textAlign: TextAlign.center,
    );
  }
}
