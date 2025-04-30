import 'package:service_reservation_app/data/models/specialist_model.dart'
    show Specialist;

import '../../repositories/specialist_repository.dart';

class GetAllSpecialistsUseCase {
  final SpecialistRepository specialistRepository;

  GetAllSpecialistsUseCase({required this.specialistRepository});

  Future<List<Specialist>> execute() async {
    return await specialistRepository.getAllSpecialists();
  }
}
