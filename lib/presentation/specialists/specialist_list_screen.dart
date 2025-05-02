import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/controllers/SpecialistController.dart' show SpecialistController;

class SpecialistListScreen extends GetView<SpecialistController> {
  const SpecialistListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Specialists')),
      body: const Center(
        child: Text('Specialist List Screen'),
      ),
    );
  }
}