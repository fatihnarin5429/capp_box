import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsule_repository.dart';

abstract class ICreateCapsulesRepository {
  Future<CreateCapsuleModel> createCapsule({
    required String title,
    required String message,
    required String email,
    required String phone,
    required String price,
  });
}

class CreateCapsulesUsecase implements ICreateCapsulesRepository {
  final CreateCapsulesRemoteDatasource datasource;

  CreateCapsulesUsecase(this.datasource);

  @override
  Future<CreateCapsuleModel> createCapsule({
    required String title,
    required String message,
    required String email,
    required String phone,
    required String price,
  }) {
    return datasource.createCapsule(
      title: title,
      message: message,
      email: email,
      phone: phone,
      price: price,
    );
  }
}
