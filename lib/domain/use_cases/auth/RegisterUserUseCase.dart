import 'package:service_reservation_app/data/models/user_model.dart' show UserModel;
import 'package:service_reservation_app/domain/repositories/user_repository.dart'
    show UserRepository;

class RegisterUserUseCase {
  final UserRepository userRepository;

  RegisterUserUseCase({required this.userRepository});

  Future<UserModel?> execute(String name, String email, String password) async {
    return await userRepository.register(name, email, password);
  }
}
