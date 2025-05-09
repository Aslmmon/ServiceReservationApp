
import '../../repositories/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository userRepository;

  GetCurrentUserUseCase({required this.userRepository});

  String? execute() {
    return  userRepository.getCurrentUserId();
  }
}
