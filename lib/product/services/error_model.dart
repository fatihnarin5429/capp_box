import 'package:dio/dio.dart';

/// API'den gelen ya da istemci kaynaklı hataları kapsayan model
class ErrorModel {
  final String message;
  final int? statusCode;
  final DioExceptionType? dioType;
  final String? logId;
  final String? rawError;
  final dynamic responseData;

  ErrorModel({
    required this.message,
    this.statusCode,
    this.dioType,
    this.logId,
    this.rawError,
    this.responseData,
  });

  @override
  String toString() =>
      'ErrorModel(message: $message, statusCode: $statusCode, dioType: $dioType, rawError: $rawError, logId: $logId)';
}

class NetworkException implements Exception {
  final ErrorModel error;
  NetworkException(this.error);

  @override
  String toString() => 'NetworkException → $error';
}
