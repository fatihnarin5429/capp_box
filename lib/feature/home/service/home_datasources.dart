import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';
import 'package:capp_box/product/services/network_client.dart';
import 'package:capp_box/product/services/services_paths.dart';

class HomeRemoteDatasource {
  HomeRemoteDatasource();

  final NetworkClient client = NetworkClient();

  Future<List<CreateCapsuleResponseModel>> fetchCapsules() async {
    final path = ServicePath.capsules.value;
    final res = await client.get<Map<String, dynamic>>(path);
    final map = res.data;
    if (map == null || map['data'] is! List) {
      throw const FormatException('Beklenmeyen format');
    }
    return map['data']
        .map((e) => CreateCapsuleResponseModel.fromJson(e))
        .toList();
  }
}
