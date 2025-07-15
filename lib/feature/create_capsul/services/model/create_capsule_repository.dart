import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';

abstract class ICreateCapsulesRepository {
  Future<CreateCapsuleResponseModel> createCapsule({
    required String title,
    required String message,
    required String recipientEmail,
    required String recipientPhone,
    required String openDate,
    required int price,
  });
}
