import 'package:capp_box/feature/create_capsul/model/get_capsule_response_model.dart';
import 'package:capp_box/product/services/network_client.dart';
import 'package:capp_box/product/services/services_paths.dart';
import 'package:capp_box/product/database/hive/core/hive_database_manager.dart';
import 'package:dio/dio.dart';

class HomeRemoteDatasource {
  HomeRemoteDatasource();

  final NetworkClient client = NetworkClient();
  final HiveDatabaseManager hiveDatabaseManager = HiveDatabaseManager();

  Future<GetCapsulesResponseModel> fetchCapsules() async {
    try {
      // Kullanıcı token'ını al
      final userModel = await hiveDatabaseManager.getUserModel();
      if (userModel?.token == null) {
        throw const FormatException('Kullanıcı giriş yapmamış');
      }

      final path = ServicePath.capsules.value;
      final res = await client.get<Map<String, dynamic>>(
        path,
        options: Options(headers: {'Authorization': userModel!.token!}),
      );
      final map = res.data;
      if (map == null) {
        throw const FormatException('Beklenmeyen format');
      }
      return GetCapsulesResponseModel.fromJson(map);
    } catch (e) {
      if (e.toString().contains('Kullanıcı giriş yapmamış')) {
        throw const FormatException('Lütfen giriş yapın');
      }
      throw FormatException('Kapsüller getirilirken bir hata oluştu: $e');
    }
  }
}
