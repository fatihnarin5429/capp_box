import 'package:capp_box/feature/create_capsul/model/create_capsule_body_model.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsule_datasources.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsule_repository.dart';

class CreateCapsulesUsecase implements ICreateCapsulesRepository {
  final CreateCapsulesRemoteDatasource datasource;

  CreateCapsulesUsecase(this.datasource);

  @override
  Future<CreateCapsuleResponseModel> createCapsule({
    required CreateCapsuleBodyModel createCapsuleBodyModel,
    required String token,
  }) {
    return datasource.createCapsule(
      token: token,
      createCapsuleBodyModel: createCapsuleBodyModel,
    );
  }
}
