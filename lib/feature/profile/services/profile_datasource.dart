import 'package:capp_box/feature/login/services/model/user_model.dart';
import 'package:capp_box/product/services/network_client.dart';

class ProfileRemoteDatasource {
  final NetworkClient client = NetworkClient();

  Future<UserModel> fetchProfile(String userId) async {
    final res = await client.get<Map<String, dynamic>>(
      'auth/profile',
      queryParameters: {'userId': userId},
    );
    return UserModel.fromJson(res.data ?? {});
  }

  Future<UserModel> updateProfile(UserModel user) async {
    final res = await client.put<Map<String, dynamic>>(
      'auth/profile/update',
      data: user.toJson(),
    );
    return UserModel.fromJson(res.data ?? {});
  }
}
