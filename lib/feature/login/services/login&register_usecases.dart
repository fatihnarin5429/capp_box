import 'package:capp_box/feature/login/services/login&register_datasources.dart';
import 'package:capp_box/feature/login/services/login&register_repository.dart';
import 'package:capp_box/feature/login/services/model/login_response_model.dart';
import 'package:capp_box/feature/login/services/model/register_response_model.dart';
import 'package:capp_box/feature/login/services/model/user_model.dart';

class LoginRegisterUsecase implements ILoginRegisterRepository {
  final LoginRegisterRemoteDatasource datasource;

  LoginRegisterUsecase(this.datasource);

  @override
  Future<RegisterResponseModel> register({
    required String name,

    required String email,
    required String phone,
    required String password,
  }) {
    return datasource.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }
}

class LoginUsecase implements ILoginRepository {
  final LoginRegisterRemoteDatasource datasource;

  LoginUsecase(this.datasource);

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) {
    return datasource.login(email: email, password: password);
  }
}
