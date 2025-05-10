import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/repositories/specialist_repository.dart';
import '../models/specialist_model.dart' show Specialist;
import 'fb_collections.dart';

class FirebaseSpecialistRepository implements SpecialistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Specialist>> getAllSpecialists() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection(specialistsCollection).get();
    return snapshot.docs.map((doc) => Specialist.fromFirestore(doc)).toList();
  }

  @override
  Future<Specialist?> getSpecialistById(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection(specialistsCollection).doc(id).get();
    if (snapshot.exists) {
      return Specialist.fromFirestore(snapshot);
    }
    return null;
  }
}
