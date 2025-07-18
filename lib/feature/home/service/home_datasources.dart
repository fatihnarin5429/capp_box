import 'package:capp_box/feature/create_capsul/model/get_capsule_response_model.dart';
import 'package:capp_box/product/services/network_client.dart';
import 'package:capp_box/product/services/services_paths.dart';
import 'package:dio/dio.dart';

class HomeRemoteDatasource {
  HomeRemoteDatasource();

  final NetworkClient client = NetworkClient();

  Future<GetCapsulesResponseModel> fetchCapsules() async {
    try {
      final path = ServicePath.capsules.value;
      final res = await client.get<Map<String, dynamic>>(
        path,
        options: Options(headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4NzRmYjkyNzJmZDVkMjk0ZDg2NTkwMiIsImlhdCI6MTc1MjcwOTg3MiwiZXhwIjoxNzUzMzE0NjcyfQ.QkFYyKFQ-zF0fXbkyiol6Uc3qicWhEYBfxSz65Q_FEY',
      }),
      );
      final map = res.data;
      if (map == null) {
        throw const FormatException('Beklenmeyen format');
      }
      return GetCapsulesResponseModel.fromJson(map);
    } catch (e) {
      throw FormatException('Kapsüller getirilirken bir hata oluştu: $e');
    }
  }
}
