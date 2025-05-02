import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/controllers/SpecialistController.dart' show SpecialistController;

class SpecialistDetailScreen extends GetView<SpecialistController> {
  const SpecialistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Specialist Details')),
      body: const Center(
        child: Text('Specialist Detail Screen'),
      ),
    );
  }
}