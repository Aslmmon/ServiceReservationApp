import 'package:service_reservation_app/domain/repositories/user_repository.dart'
    show UserRepository;

class LogoutUserUseCase {
  final UserRepository userRepository;

  LogoutUserUseCase({required this.userRepository});

  Future<void> execute() async {
    await userRepository.logout();
  }
}
