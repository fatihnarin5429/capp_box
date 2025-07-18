import 'package:capp_box/feature/create_capsul/model/create_capsule_body_model.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';

abstract class ICreateCapsulesRepository {
  Future<CreateCapsuleResponseModel> createCapsule({
    required String token,
    required CreateCapsuleBodyModel createCapsuleBodyModel,
  });
}
