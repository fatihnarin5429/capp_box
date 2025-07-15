import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsule_datasources.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsule_repository.dart';

class CreateCapsulesUsecase implements ICreateCapsulesRepository {
  final CreateCapsulesRemoteDatasource datasource;

  CreateCapsulesUsecase(this.datasource);

  @override
  Future<CreateCapsuleResponseModel> createCapsule({
    required String title,
    required String message,
    required String recipientEmail,
    required String recipientPhone,
    required String openDate,
    required int price,
  }) {
    return datasource.createCapsule(
      title: title,
      message: message,
      recipientEmail: recipientEmail,
      recipientPhone: recipientPhone,
      openDate: openDate,
      price: price,
    );
  }
}
