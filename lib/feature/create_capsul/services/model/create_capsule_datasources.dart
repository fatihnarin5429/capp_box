import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_body_model.dart';
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
    required CreateCapsuleBodyModel createCapsuleBodyModel,
    required String token,
  }) async {
    try {
      final path = ServicePath.capsules.value;
      final res = await client.post<Map<String, dynamic>>(
        path,
        data: createCapsuleBodyModel.toJson(), // Fixed: Remove extra map wrapping
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Connection': 'keep-alive',
          },
        ),
      );
      print('responsee${res.data}');
      final map = res.data;
      if (res.statusCode != null) {
        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          return CreateCapsuleResponseModel.fromJson(map ?? {});
        } else if (res.statusCode! >= 400 && res.statusCode! < 500) {
          throw Exception('Client error: ${res.statusCode}');
        } else if (res.statusCode! >= 500 && res.statusCode! < 600) {
          throw Exception('Server error: ${res.statusCode}');
        }
      }
      throw Exception('Invalid response status code');
    } catch (e) {
      BotToast.showText(text: 'Kapsül oluştururken hata oluştu: $e');
      throw Exception('Kapsül oluştururken hata oluştu: $e');
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
