import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/login/services/model/register_response_model.dart';
import 'package:capp_box/product/services/network_client.dart';
import 'package:capp_box/product/services/services_paths.dart';
import 'package:dio/dio.dart';

class LoginRegisterRemoteDatasource {
  LoginRegisterRemoteDatasource();

  final NetworkClient client = NetworkClient();

  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final path = ServicePath.register.value;
      final res = await client.post<Map<String, dynamic>>(
        path,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
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

  Future<void> login(String email, String password) async {
    final path = ServicePath.capsules.value;
    final res = await client.get<Map<String, dynamic>>(path);
    final map = res.data;
    if (map == null || map['data'] is! List) {
      throw FormatException('Beklenmeyen format');
    }
    return map['data'].map((e) => CreateCapsuleModel.fromJson(e)).toList();
  }
}
