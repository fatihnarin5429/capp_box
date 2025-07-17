import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class CreateCapsuleBodyModel {
  final String? title;
  final String? message;
  final String? recipientEmail;
  final String? recipientPhone;
  final String? openDate;
  final double? price;
  final String? paymentMethod;
  final File? mediaFiles; // tek dosya

  const CreateCapsuleBodyModel({
    this.title,
    this.message,
    this.recipientEmail,
    this.recipientPhone,
    this.openDate,
    this.price,
    this.paymentMethod,
    this.mediaFiles,
  });

  CreateCapsuleBodyModel copyWith({
    String? title,
    String? message,
    String? recipientEmail,
    String? recipientPhone,
    String? openDate,
    double? price,
    String? paymentMethod,
    File? mediaFiles,
  }) {
    return CreateCapsuleBodyModel(
      title: title ?? this.title,
      message: message ?? this.message,
      recipientEmail: recipientEmail ?? this.recipientEmail,
      recipientPhone: recipientPhone ?? this.recipientPhone,
      openDate: openDate ?? this.openDate,
      price: price ?? this.price,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      mediaFiles: mediaFiles ?? this.mediaFiles,
    );
  }

  /// JSON parse/generate ihtiyacın varsa tut, ama upload için kullanma:
  factory CreateCapsuleBodyModel.fromJson(Map<String, dynamic> json) =>
      CreateCapsuleBodyModel(
        title: json['title'] as String?,
        message: json['message'] as String?,
        recipientEmail: json['recipientEmail'] as String?,
        recipientPhone: json['recipientPhone'] as String?,
        openDate: json['openDate'] as String?,
        price: (json['price'] as num?)?.toDouble(),
        paymentMethod: json['paymentMethod'] as String?,
        mediaFiles: json['mediaFiles'] != null
            ? File(json['mediaFiles'] as String)
            : null,
      );

  Map<String, dynamic> toJson() {
    // Sadece JSON ihtiyaçları için; dosya yüklemede kullanma
    return {
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (recipientEmail != null) 'recipientEmail': recipientEmail,
      if (recipientPhone != null) 'recipientPhone': recipientPhone,
      if (openDate != null) 'openDate': openDate,
      if (price != null) 'price': price,
      if (paymentMethod != null) 'paymentMethod': paymentMethod,
    };
  }

  /// **Dosya ve diğer alanları** multipart/form-data olarak paketler:
  Future<FormData> toFormData() async {
    final map = <String, dynamic>{
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (recipientEmail != null) 'recipientEmail': recipientEmail,
      if (recipientPhone != null) 'recipientPhone': recipientPhone,
      if (openDate != null) 'openDate': openDate,
      if (price != null) 'price': price,
      if (paymentMethod != null) 'paymentMethod': paymentMethod,
    };

    if (mediaFiles != null) {
      final multipart = await MultipartFile.fromFile(
        mediaFiles!.path,
        filename: basename(mediaFiles!.path),
      );
      map['mediaFiles'] = multipart;
    }

    return FormData.fromMap(map);
  }
}
