import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../../domain/repositories/user_repository.dart';
import '../../../data/models/user_model.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final String _usersCollection = 'users';

  @override
  Future<UserModel?> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final auth.UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        final UserModel user = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
        );
        await _firestore
            .collection(_usersCollection)
            .doc(user.id)
            .set(user.toFirestore());
        return user;
      }
      return null;
    } catch (e) {
      print('Error registering user: $e');
      return null;
    }
  }

  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      final auth.UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _firestore
                .collection(_usersCollection)
                .doc(userCredential.user!.uid)
                .get();
        return UserModel.fromFirestore(snapshot);
      }
      return null;
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  String? getCurrentUserId()  {
    final auth.User? currentUser = _auth.currentUser;
    return currentUser?.uid;
  }
}
