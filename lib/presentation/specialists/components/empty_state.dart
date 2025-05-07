import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message, // Ensure message is translatable
      textAlign: TextAlign.center,
    );
  }
}