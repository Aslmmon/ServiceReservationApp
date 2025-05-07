import 'package:service_reservation_app/data/models/user_model.dart' show UserModel;

abstract class UserRepository {
  Future<UserModel?> register(String name, String email, String password);

  Future<UserModel?> login(String email, String password);

  Future<void> logout();

  Future<UserModel?> getCurrentUser();

  Future<UserModel?> getUserById(String id);
}
