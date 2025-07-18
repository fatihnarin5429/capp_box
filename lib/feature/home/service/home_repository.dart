import 'package:capp_box/feature/create_capsul/model/get_capsule_response_model.dart';

abstract class IHomeRepository {
  Future<GetCapsulesResponseModel> fetchCapsules();
}
