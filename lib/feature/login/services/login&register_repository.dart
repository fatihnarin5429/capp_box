import 'package:capp_box/feature/login/services/model/register_response_model.dart';

abstract class ILoginRegisterRepository {
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });
}
