import 'package:service_reservation_app/data/models/specialist_model.dart'
    show Specialist;

abstract class SpecialistRepository {
  Future<List<Specialist>> getAllSpecialists();

  Future<Specialist?> getSpecialistById(String id);
}
