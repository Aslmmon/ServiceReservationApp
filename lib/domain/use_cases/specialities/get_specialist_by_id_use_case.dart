import 'package:service_reservation_app/data/models/specialist_model.dart'
    show Specialist;

import '../../repositories/specialist_repository.dart';

class GetSpecialistByIdUseCase {
  final SpecialistRepository specialistRepository;

  GetSpecialistByIdUseCase({required this.specialistRepository});

  Future<Specialist?> execute(String id) async {
    return await specialistRepository.getSpecialistById(id);
  }
}
