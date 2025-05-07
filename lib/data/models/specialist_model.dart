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
    final availableDaysMap =
        data?['availableDays'] as Map<String, dynamic>? ?? {};
    final parsedAvailableDays = <String, List<dynamic>>{};
    availableDaysMap.forEach((key, value) {
      parsedAvailableDays[key] =
          (value as List<dynamic>?)?.cast<String>().toList() ?? [];
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

List<Specialist> specialistLists = [
  Specialist(
    id: 'cardio01',
    name: 'Dr. Heartbeat',
    specialization: 'Cardiologist',
    bio: 'Expert in adult cardiology and echocardiography.',
    availableDays: {
      'Monday': ['9:00', '11:00'],
      'Wednesday': ['14:00', '16:00'],
      'Friday': ['10:00'],
    },
  ),
  Specialist(
    id: 'derm01',
    name: 'Dr. SkinCare',
    specialization: 'Dermatologist',
    bio: 'Focuses on medical and cosmetic dermatology.',
    availableDays: {
      'Monday': ['13:00', '16:00'],
      'Wednesday': ['9:00', '12:00'],
    },
  ),
  Specialist(
    id: 'neuro01',
    name: 'Dr. Neuron',
    specialization: 'Neurologist',
    bio: 'Diagnoses and treats disorders of the nervous system.',
    availableDays: {
      'Tuesday': ['9:30', '11:30'],
      'Thursday': ['14:30', '16:30'],
    },
  ),
  Specialist(
    id: 'ortho01',
    name: 'Dr. Joint',
    specialization: 'Orthopedic Surgeon',
    bio: 'Performs joint replacements and sports injury surgeries.',
    availableDays: {
      'Monday': ['8:00', '10:00'],
      'Thursday': ['16:00', '18:00'],
    },
  ),
  Specialist(
    id: 'ped01',
    name: 'Dr. ChildCare',
    specialization: 'Pediatrician',
    bio: 'Provides comprehensive healthcare for infants and children.',
    availableDays: {
      'Tuesday': ['11:00', '13:00'],
      'Thursday': ['9:00', '11:00'],
      'Friday': ['15:30'],
    },
  ),
  Specialist(
    id: 'dentist01',
    name: 'Dr. Smile',
    specialization: 'Dentist',
    bio: 'Offers general and cosmetic dentistry services.',
    availableDays: {
      'Monday': ['9:00', '12:00'],
      'Thursday': ['14:00', '17:00'],
    },
  ),
  Specialist(
    id: 'psych01',
    name: 'Dr. Mindful',
    specialization: 'Psychologist',
    bio: 'Provides therapy for anxiety, depression, and stress.',
    availableDays: {
      'Wednesday': ['15:30', '17:30'],
      'Friday': ['16:00', '18:00'],
    },
  ),
  Specialist(
    id: 'physio01',
    name: 'Dr. MoveWell',
    specialization: 'Physiotherapist',
    bio: 'Helps patients recover from injuries and improve mobility.',
    availableDays: {
      'Tuesday': ['8:30', '10:30'],
      'Friday': ['13:00', '15:00'],
    },
  ),
  Specialist(
    id: 'opth01',
    name: 'Dr. SeeClear',
    specialization: 'Ophthalmologist',
    bio: 'Provides eye exams and treats eye diseases.',
    availableDays: {
      'Monday': ['14:00', '16:00'],
      'Friday': ['8:30', '10:30'],
    },
  ),
  Specialist(
    id: 'gastro01',
    name: 'Dr. GutFeel',
    specialization: 'Gastroenterologist',
    bio: 'Diagnoses and treats digestive system disorders.',
    availableDays: {
      'Wednesday': ['10:30', '12:30'],
      'Friday': ['17:00', '19:00'],
    },
  ),
  Specialist(
    id: 'cardio02',
    name: 'Dr. Valve',
    specialization: 'Cardiologist',
    bio: 'Specializes in interventional cardiology.',
    availableDays: {
      'Tuesday': ['10:00', '12:00'],
      'Thursday': ['15:00', '17:00'],
    },
  ),
  Specialist(
    id: 'derm02',
    name: 'Dr. ClearSkin',
    specialization: 'Dermatologist',
    bio: 'Specialist in acne treatment and skin cancer screening.',
    availableDays: {
      'Tuesday': ['14:00', '17:00'],
      'Friday': ['11:00', '14:00'],
    },
  ),
  Specialist(
    id: 'neuro02',
    name: 'Dr. Brainy',
    specialization: 'Neurologist',
    bio: 'Specializes in epilepsy and headache management.',
    availableDays: {
      'Monday': ['15:00', '17:00'],
      'Wednesday': ['10:00', '12:00'],
      'Friday': ['14:30'],
    },
  ),
  Specialist(
    id: 'ortho02',
    name: 'Dr. BoneSetter',
    specialization: 'Orthopedic Surgeon',
    bio: 'Focuses on fracture care and pediatric orthopedics.',
    availableDays: {
      'Wednesday': ['13:00', '15:00'],
      'Friday': ['9:00', '11:00'],
    },
  ),
  Specialist(
    id: 'ped02',
    name: 'Dr. Tiny',
    specialization: 'Pediatrician',
    bio: 'Specializes in neonatology and infant nutrition.',
    availableDays: {
      'Monday': ['16:00', '18:00'],
      'Wednesday': ['11:30', '13:30'],
    },
  ),
];
