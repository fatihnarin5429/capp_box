import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';

abstract class ICreateCapsulesRepository {
  Future<CreateCapsuleModel> createCapsule({
    required String title,
    required String message,
    required String email,
    required String phone,
    required String price,
  });
}
