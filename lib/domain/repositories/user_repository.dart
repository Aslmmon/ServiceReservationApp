import 'package:service_reservation_app/data/models/user_model.dart' show User;

abstract class UserRepository {
  Future<User?> register(String name, String email, String password);

  Future<User?> login(String email, String password);

  Future<void> logout();

  Future<User?> getCurrentUser();

  Future<User?> getUserById(String id);
}
