import 'package:service_reservation_app/data/models/user_model.dart' show User;

import '../../repositories/user_repository.dart';

class LoginUserUseCase {
  final UserRepository userRepository;

  LoginUserUseCase({required this.userRepository});

  Future<User?> execute(String email, String password) async {
    return await userRepository.login(email, password);
  }
}