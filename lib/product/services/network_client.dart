import 'package:capp_box/product/services/error_model.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkClient {
  final Dio dio = Dio();
  final String baseUrl = dotenv.env['api-url-cappbox'] ?? '';

  NetworkClient() {
    _setupDio();
  }

  void _setupDio() {
    dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 6)
      ..sendTimeout = const Duration(seconds: 6)
      ..receiveTimeout = const Duration(seconds: 6);

    dio.interceptors
      ..clear()
      ..addAll([_buildRetryInterceptor(), ChuckerDioInterceptor()]);
  }

  RetryInterceptor _buildRetryInterceptor() => RetryInterceptor(
    dio: dio,
    logPrint: (Object? object) {},
    retries: 3,
    retryDelays: const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
    ],
    retryEvaluator: (error, _) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return true;
      }
      final code = error.response?.statusCode ?? 0;
      return [500, 502, 503, 504].contains(code);
    },
  );

  Future<Response<T>> _safeRequest<T>(
    Future<Response<T>> Function() request,
  ) async => request().catchError((e) {
    if (e is DioException) {
      final data = e.response?.data;
      throw NetworkException(
        ErrorModel(
          message: _mapDioErrorToMessage(e),
          statusCode: e.response?.statusCode,
          dioType: e.type,
          rawError: _extractBackendError(data),
          responseData: data,
        ),
      );
    }
    throw NetworkException(ErrorModel(message: 'Bilinmeyen hata: $e'));
  });

  String? _extractBackendError(dynamic data) {
    if (data is Map<String, dynamic> && data['message'] != null) {
      return data['message'].toString();
    }
    return null;
  }

  String _mapDioErrorToMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Bağlantı zaman aşımına uğradı.';
      case DioExceptionType.badCertificate:
        return 'SSL sertifika hatası.';
      case DioExceptionType.badResponse:
        return 'Sunucudan geçersiz yanıt alındı.';
      case DioExceptionType.cancel:
        return 'İstek iptal edildi.';
      case DioExceptionType.connectionError:
        return 'İnternet bağlantısı yok.';
      case DioExceptionType.unknown:
        return 'Bilinmeyen ağ hatası.';
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) => _safeRequest(
    () => dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) => _safeRequest(
    () => dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) => _safeRequest(
    () => dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) => _safeRequest(
    () => dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _safeRequest(
    () => dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ),
  );

  Future<Response<dynamic>> download(
    String urlPath,
    dynamic savePath, {
    void Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    dynamic data,
    Options? options,
  }) => _safeRequest(
    () => dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    ),
  );
}
