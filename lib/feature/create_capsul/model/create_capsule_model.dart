import 'dart:io';

import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:equatable/equatable.dart';

class CreateCapsuleModel extends Equatable {
  final String? title;
  final String? message;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? openedDate;
  final File? mediaUrl;
  final MediaType? mediaType;
  final bool? isSendInfoReceiver;
  final bool? isSendInfoSms;
  final bool? isCreatedByMe;

  const CreateCapsuleModel({
    this.title,
    this.message,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.openedDate,
    this.mediaUrl,
    this.mediaType,
    this.isSendInfoReceiver,
    this.isSendInfoSms,
    this.isCreatedByMe = true,
  });

  @override
  List<Object?> get props => [
        title,
        message,
        displayName,
        openedDate,
        email,
        phoneNumber,
        mediaType,
        isSendInfoReceiver,
        isSendInfoSms,
        isCreatedByMe,
      ];

  // JSON'dan nesne oluşturma
  factory CreateCapsuleModel.fromJson(Map<String, dynamic> json) {
    return CreateCapsuleModel(
      title: json['title'] as String?,
      message: json['message'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      openedDate: json['openedDate'] as String?,
      mediaUrl: json['mediaUrl'] as File?,
      mediaType: _mediaTypeFromString(json['mediaType'] as String?),
      isSendInfoReceiver: json['isSendInfoReceiver'] as bool?,
      isSendInfoSms: json['isSendInfoSms'] as bool?,
      isCreatedByMe: json['isCreatedByMe'] as bool?,
    );
  }

  // JSON'a çevirme
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'openedDate': openedDate,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType?.name,
      'isSendInfoReceiver': isSendInfoReceiver,
      'isSendInfoSms': isSendInfoSms,
      'isCreatedByMe': isCreatedByMe,
    };
  }

  // copyWith
  CreateCapsuleModel copyWith({
    String? title,
    String? message,
    String? displayName,
    String? openedDate,
    String? email,
    String? phoneNumber,
    File? mediaUrl,
    MediaType? mediaType,
    bool? isSendInfoReceiver,
    bool? isSendInfoSms,
    bool? isCreatedByMe,
  }) {
    return CreateCapsuleModel(
      title: title ?? this.title,
      message: message ?? this.message,
      displayName: displayName ?? this.displayName,
      openedDate: openedDate ?? this.openedDate,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      isSendInfoReceiver: isSendInfoReceiver ?? this.isSendInfoReceiver,
      isSendInfoSms: isSendInfoSms ?? this.isSendInfoSms,
      isCreatedByMe: isCreatedByMe ?? this.isCreatedByMe,
    );
  }

  // Yardımcı method (enum'u string'den dönüştürmek için)
  static MediaType? _mediaTypeFromString(String? type) {
    switch (type) {
      case 'text':
        return MediaType.text;
      case 'video':
        return MediaType.video;
      case 'audio':
        return MediaType.voice;
      case 'photo':
        return MediaType.photo;
      default:
        return null;
    }
  }

  @override
  String toString() {
    return 'CreateCapsuleModel(title: $title, message: $message, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, openedDate: $openedDate, mediaUrl: $mediaUrl, mediaType: $mediaType, isSendInfoReceiver: $isSendInfoReceiver, isSendInfoSms: $isSendInfoSms, isCreatedByMe: $isCreatedByMe)';
  }
}
