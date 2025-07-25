import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';
import 'package:capp_box/feature/login/services/model/login_response_model.dart';
import 'package:capp_box/feature/login/services/model/register_response_model.dart';
import 'package:capp_box/feature/login/services/model/user_model.dart';
import 'package:capp_box/product/services/network_client.dart';
import 'package:capp_box/product/services/services_paths.dart';
import 'package:dio/dio.dart';

class LoginRegisterRemoteDatasource {
  LoginRegisterRemoteDatasource();

  final NetworkClient client = NetworkClient();

  Future<RegisterResponseModel> register({
    required String name,
    required String email,

    required String password,
  }) async {
    try {
      final path = ServicePath.register.value;
      final res = await client.post<Map<String, dynamic>>(
        path,
        data: {'name': name, 'email': email, 'password': password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
          },
        ),
      );
      final map = res.data;
      print('API Response: $map'); // Debug için
      return RegisterResponseModel.fromJson(map ?? {});
    } catch (e) {
      print('Network error: $e'); // Debug için
      throw Exception('Kayıt işlemi sırasında bir hata oluştu: $e');
    }
  }

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final path = ServicePath.login.value;
      final res = await client.post<Map<String, dynamic>>(
        path,
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
          },
        ),
      );
      final map = res.data;
      print('Login API Response: $map'); // Debug için
      return LoginResponseModel.fromJson(map ?? {});
    } catch (e) {
      print('Login network error: $e'); // Debug için
      throw Exception('Giriş işlemi sırasında bir hata oluştu: $e');
    }
  }
}
