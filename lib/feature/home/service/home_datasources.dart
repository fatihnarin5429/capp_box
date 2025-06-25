import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/product/services/network_client.dart';
import 'package:capp_box/product/services/services_paths.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeRemoteDatasource {
  HomeRemoteDatasource();

  final NetworkClient client = NetworkClient();

  Future<List<CreateCapsuleModel>> fetchCapsules() async {
    final path = ServicePath.capsules.value;
    final res = await client.get<Map<String, dynamic>>(path);
    final map = res.data;
    if (map == null || map['data'] is! List) {
      throw FormatException('Beklenmeyen format');
    }
    return map['data'].map((e) => CreateCapsuleModel.fromJson(e)).toList();
  }
}
