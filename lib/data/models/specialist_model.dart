import 'package:cloud_firestore/cloud_firestore.dart';

class Specialist {
  final String id;
  final String name;
  final String specialization;
  final String? bio;
  final Map<String, List<dynamic>> availableDays;

  Specialist({
    required this.id,
    required this.name,
    required this.specialization,
    this.bio,
    required this.availableDays,
  });

  factory Specialist.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final availableDaysMap = data?['availableDays'] as Map<String, dynamic>? ?? {};
    final parsedAvailableDays = <String, List<dynamic>>{};
    availableDaysMap.forEach((key, value) {
      parsedAvailableDays[key] = (value as List<dynamic>?)?.cast<String>().toList() ?? [];
    });
    return Specialist(
      id: doc.id,
      name: data?['name'] as String? ?? '',
      specialization: data?['specialization'] as String? ?? '',
      bio: data?['bio'] as String?,
      availableDays: parsedAvailableDays,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'specialization': specialization,
      'bio': bio,
      'availableDays': availableDays,
    };
  }
}