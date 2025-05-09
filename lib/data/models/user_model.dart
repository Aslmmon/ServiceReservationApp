import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return UserModel(
      id: doc.id,
      name: data?['name'] as String? ?? '',
      email: data?['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromFirestoreMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String? ?? '', // Assuming you saved 'id' in toFirestore
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
    );
  }


}