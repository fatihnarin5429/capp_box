import '../../../product/utility/enums/mediaType_enum.dart';

class CreateCapsuleResponseModel {
  final bool success;
  final String message;
  final CapsuleData data;
  final String recipientPhone;
  final String recipientEmail;
  final String openDate;
  final int price;

  CreateCapsuleResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.recipientPhone,
    required this.recipientEmail,
    required this.openDate,
    required this.price,
  });

  CreateCapsuleResponseModel copyWith({
    bool? success,
    String? recipientPhone,
    String? recipientEmail,
    String? openDate,
    int? price,
    String? message,
    CapsuleData? data,
  }) {
    return CreateCapsuleResponseModel(
      recipientPhone: recipientPhone ?? this.recipientPhone,
      recipientEmail: recipientEmail ?? this.recipientEmail,
      openDate: openDate ?? this.openDate,
      price: price ?? this.price,
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory CreateCapsuleResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateCapsuleResponseModel(
      recipientPhone: json['recipientPhone'] ?? '',
      recipientEmail: json['recipientEmail'] ?? '',
      openDate: json['openDate'] ?? '',
      price: json['price'] ?? 0,
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CapsuleData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.toJson(),
  };

  String get recipientName => data.capsule.recipientEmail;
  String get openedDate => data.capsule.openDate.toIso8601String();
  String get displayName => data.capsule.title;
  String get senderName => data.capsule.sender;
}

class CapsuleData {
  final Capsule capsule;
  final String paymentId;

  CapsuleData({required this.capsule, required this.paymentId});

  factory CapsuleData.fromJson(Map<String, dynamic> json) {
    return CapsuleData(
      capsule: Capsule.fromJson(json['capsule'] ?? {}),
      paymentId: json['paymentId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'capsule': capsule.toJson(),
    'paymentId': paymentId,
  };

  CapsuleData copyWith({Capsule? capsule, String? paymentId}) {
    return CapsuleData(
      capsule: capsule ?? this.capsule,
      paymentId: paymentId ?? this.paymentId,
    );
  }
}

class Capsule {
  final String title;
  final String message;
  final String sender;
  final String recipientEmail;
  final String recipientPhone;
  final String? recipientUser;
  final bool isClaimed;
  final DateTime openDate;
  final bool isOpened;
  final double price;
  final String paymentStatus;
  final bool notificationSentToUnregistered;
  final bool notificationSentToRegistered;
  final String id;
  final List<Media> media;
  final DateTime createdAt;
  final int v;

  Capsule({
    required this.title,
    required this.message,
    required this.sender,
    required this.recipientEmail,
    required this.recipientPhone,
    this.recipientUser,
    required this.isClaimed,
    required this.openDate,
    required this.isOpened,
    required this.price,
    required this.paymentStatus,
    required this.notificationSentToUnregistered,
    required this.notificationSentToRegistered,
    required this.id,
    required this.media,
    required this.createdAt,
    required this.v,
  });

  factory Capsule.fromJson(Map<String, dynamic> json) {
    return Capsule(
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      sender: json['sender'] ?? '',
      recipientEmail: json['recipientEmail'] ?? '',
      recipientPhone: json['recipientPhone'] ?? '',
      recipientUser: json['recipientUser'],
      isClaimed: json['isClaimed'] ?? false,
      openDate: DateTime.tryParse(json['openDate'] ?? '') ?? DateTime.now(),
      isOpened: json['isOpened'] ?? false,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      paymentStatus: json['paymentStatus'] ?? '',
      notificationSentToUnregistered:
          json['notificationSentToUnregistered'] ?? false,
      notificationSentToRegistered:
          json['notificationSentToRegistered'] ?? false,
      id: json['_id'] ?? '',
      media:
          (json['media'] as List<dynamic>? ?? [])
              .map((e) => Media.fromJson(e as Map<String, dynamic>))
              .toList(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'message': message,
    'sender': sender,
    'recipientEmail': recipientEmail,
    'recipientPhone': recipientPhone,
    'recipientUser': recipientUser,
    'isClaimed': isClaimed,
    'openDate': openDate.toIso8601String(),
    'isOpened': isOpened,
    'price': price,
    'paymentStatus': paymentStatus,
    'notificationSentToUnregistered': notificationSentToUnregistered,
    'notificationSentToRegistered': notificationSentToRegistered,
    '_id': id,
    'media': media.map((e) => e.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    '__v': v,
  };

  Capsule copyWith({
    String? title,
    String? message,
    String? sender,
    String? recipientEmail,
    String? recipientPhone,
    String? recipientUser,
    bool? isClaimed,
    DateTime? openDate,
    bool? isOpened,
    double? price,
    String? paymentStatus,
    bool? notificationSentToUnregistered,
    bool? notificationSentToRegistered,
    String? id,
    List<Media>? media,
    DateTime? createdAt,
    int? v,
  }) {
    return Capsule(
      title: title ?? this.title,
      message: message ?? this.message,
      sender: sender ?? this.sender,
      recipientEmail: recipientEmail ?? this.recipientEmail,
      recipientPhone: recipientPhone ?? this.recipientPhone,
      recipientUser: recipientUser ?? this.recipientUser,
      isClaimed: isClaimed ?? this.isClaimed,
      openDate: openDate ?? this.openDate,
      isOpened: isOpened ?? this.isOpened,
      price: price ?? this.price,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      notificationSentToUnregistered:
          notificationSentToUnregistered ?? this.notificationSentToUnregistered,
      notificationSentToRegistered:
          notificationSentToRegistered ?? this.notificationSentToRegistered,
      id: id ?? this.id,
      media: media ?? this.media,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
    );
  }

  /// UI için kolaylık: ilk medya tipi ve url'si
  MediaType get mediaType =>
      media.isNotEmpty ? media.first.type : MediaType.text;
  String? get mediaUrl => media.isNotEmpty ? media.first.url : null;
}

class Media {
  final MediaType type;
  final String url;
  final String mimetype;
  final int size;
  final String id;

  Media({
    required this.type,
    required this.url,
    required this.mimetype,
    required this.size,
    required this.id,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: mediaTypeFromString(json['type'] ?? ''),
      url: json['url'] ?? '',
      mimetype: json['mimetype'] ?? '',
      size: json['size'] ?? 0,
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'type': mediaTypeToString(type),
    'url': url,
    'mimetype': mimetype,
    'size': size,
    '_id': id,
  };
}
