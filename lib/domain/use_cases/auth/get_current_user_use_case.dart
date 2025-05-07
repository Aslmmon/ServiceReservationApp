import 'package:service_reservation_app/data/models/user_model.dart' show UserModel;

import '../../repositories/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository userRepository;

  GetCurrentUserUseCase({required this.userRepository});

  Future<UserModel?> execute() async {
    return await userRepository.getCurrentUser();
  }
}
