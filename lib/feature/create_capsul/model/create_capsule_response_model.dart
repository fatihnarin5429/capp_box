class CreateCapsuleResponseModel {
  final bool? success;
  final String? message;
  final CreateCapsuleData? data;

  CreateCapsuleResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory CreateCapsuleResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateCapsuleResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? CreateCapsuleData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}

class CreateCapsuleData {
  final Capsule? capsule;
  final String? paymentId;

  CreateCapsuleData({
    this.capsule,
    this.paymentId,
  });

  factory CreateCapsuleData.fromJson(Map<String, dynamic> json) {
    return CreateCapsuleData(
      capsule: json['capsule'] != null
          ? Capsule.fromJson(json['capsule'] as Map<String, dynamic>)
          : null,
      paymentId: json['paymentId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'capsule': capsule?.toJson(),
        'paymentId': paymentId,
      };
}

class Capsule {
  final String? title;
  final String? message;
  final String? sender;
  final String? recipientEmail;
  final String? recipientPhone;
  final String? recipientUser;
  final bool? isClaimed;
  final DateTime? openDate;
  final bool? isOpened;
  final List<Media>? media;
  final double? price;
  final String? paymentStatus;
  final bool? notificationSentToUnregistered;
  final bool? notificationSentToRegistered;
  final String? id;
  final DateTime? createdAt;
  final int? v;

  Capsule({
    this.title,
    this.message,
    this.sender,
    this.recipientEmail,
    this.recipientPhone,
    this.recipientUser,
    this.isClaimed,
    this.openDate,
    this.isOpened,
    this.media,
    this.price,
    this.paymentStatus,
    this.notificationSentToUnregistered,
    this.notificationSentToRegistered,
    this.id,
    this.createdAt,
    this.v,
  });

  factory Capsule.fromJson(Map<String, dynamic> json) {
    var mediaJson = json['media'] as List<dynamic>?;
    return Capsule(
      title: json['title'] as String?,
      message: json['message'] as String?,
      sender: json['sender'] as String?,
      recipientEmail: json['recipientEmail'] as String?,
      recipientPhone: json['recipientPhone'] as String?,
      recipientUser: json['recipientUser'] as String?,
      isClaimed: json['isClaimed'] as bool?,
      openDate: json['openDate'] != null
          ? DateTime.parse(json['openDate'] as String)
          : null,
      isOpened: json['isOpened'] as bool?,
      media: mediaJson
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: (json['price'] as num?)?.toDouble(),
      paymentStatus: json['paymentStatus'] as String?,
      notificationSentToUnregistered:
          json['notificationSentToUnregistered'] as bool?,
      notificationSentToRegistered:
          json['notificationSentToRegistered'] as bool?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      v: json['__v'] as int?,
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
        'openDate': openDate?.toIso8601String(),
        'isOpened': isOpened,
        'media': media?.map((e) => e.toJson()).toList(),
        'price': price,
        'paymentStatus': paymentStatus,
        'notificationSentToUnregistered': notificationSentToUnregistered,
        'notificationSentToRegistered': notificationSentToRegistered,
        '_id': id,
        'createdAt': createdAt?.toIso8601String(),
        '__v': v,
      };
}

class Media {
  final String? type;
  final String? url;
  final String? mimetype;
  final int? size;
  final String? id;

  Media({
    this.type,
    this.url,
    this.mimetype,
    this.size,
    this.id,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: json['type'] as String?,
      url: json['url'] as String?,
      mimetype: json['mimetype'] as String?,
      size: json['size'] as int?,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
        'mimetype': mimetype,
        'size': size,
        '_id': id,
      };
}
