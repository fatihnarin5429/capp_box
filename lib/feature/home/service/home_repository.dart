import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';

abstract class IHomeRepository {
  Future<List<CreateCapsuleModel>> fetchCapsules();
}
