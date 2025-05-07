import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../appColors/AppColors.dart';
import '../appTextStyle/AppTextStyles.dart';

class ReusableTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged; // Add the onChanged parameter
  final int? maxLength; // Add maxLength
  final List<TextInputFormatter>? inputFormatters; // Add inputFormatters

  const ReusableTextField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.maxLength = 20,
    this.inputFormatters, // Include it in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTextStyles.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color:
                  AppColors
                      .primaryPurple, // Use provided color or default to grey
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  Theme.of(
                    context,
                  ).primaryColor, // Use provided or primary color on focus
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 9.0,
          ),
        ),
      ),
    );
  }
}
