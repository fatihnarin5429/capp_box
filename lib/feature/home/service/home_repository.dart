import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';

abstract class IHomeRepository {
  Future<List<CreateCapsuleResponseModel>> fetchCapsules();
}
