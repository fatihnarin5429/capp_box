import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';
import 'package:capp_box/feature/create_capsul/model/get_capsule_response_model.dart';
import 'package:capp_box/feature/home/service/home_repository.dart';
import 'package:capp_box/feature/home/service/home_datasources.dart';

class HomeUsecase implements IHomeRepository {
  final HomeRemoteDatasource datasource;

  HomeUsecase(this.datasource);

  @override
  Future<GetCapsulesResponseModel> fetchCapsules() {
    return datasource.fetchCapsules();
  }
}
