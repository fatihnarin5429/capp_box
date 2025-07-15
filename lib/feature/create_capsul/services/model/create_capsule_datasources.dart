import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';
import 'package:capp_box/feature/login/services/model/register_response_model.dart';
import 'package:capp_box/product/services/network_client.dart';
import 'package:capp_box/product/services/services_paths.dart';
import 'package:dio/dio.dart';

/// Uzak sunucu ile kapsül işlemlerini yöneten veri kaynağı sınıfı.
class CreateCapsulesRemoteDatasource {
  CreateCapsulesRemoteDatasource();

  final NetworkClient client = NetworkClient();

  /// Kullanıcı kaydı yapar.
  ///
  /// [name], [email], [phone], [password], [price] parametreleri gereklidir.
  /// Başarılı olursa [RegisterResponseModel] döner.
  /// Hata olursa açıklayıcı bir [Exception] fırlatır.
  Future<CreateCapsuleResponseModel> createCapsule({
    required String title,
    required String message,
    required String recipientEmail,
    required String recipientPhone,
    required String openDate,
    required int price,
  }) async {
    try {
      final path = ServicePath.capsules.value;
      final res = await client.post<Map<String, dynamic>>(
        path,
        data: {
          'title': title,
          'message': message,
          'recipientEmail': recipientEmail,
          'recipientPhone': recipientPhone,
          'openDate': openDate,
          'price': price,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
          },
        ),
      );
      final map = res.data;
      return CreateCapsuleResponseModel.fromJson(map?['data'] ?? {});
    } catch (e) {
      throw Exception('Kayıt olurken hata oluştu: $e');
    }
  }

  /// Sunucudan kapsül listesini çeker.
  ///
  /// Başarılı olursa [List<CreateCapsuleModel>] döner.
  /// Hata olursa açıklayıcı bir [Exception] fırlatır.
  Future<List<CreateCapsuleResponseModel>> fetchCapsules() async {
    try {
      final path = ServicePath.capsules.value;
      final res = await client.get<Map<String, dynamic>>(path);
      final map = res.data;
      if (map == null || map['data'] is! List) {
        throw const FormatException('Kapsül verisi beklenen formatta değil.');
      }
      return (map['data'] as List)
          .map((e) => CreateCapsuleResponseModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Kapsüller alınırken hata oluştu: $e');
    }
  }

  /// Yeni kapsül oluşturur.
  ///
  /// [title], [message], [email], [phone], [price] parametreleri gereklidir.
  /// Başarılı olursa [CreateCapsuleModel] döner.
  /// Hata olursa açıklayıcı bir [Exception] fırlatır.
}
