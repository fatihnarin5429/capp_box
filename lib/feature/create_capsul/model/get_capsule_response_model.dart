class GetCapsulesResponseModel {
  final bool? success;
  final int? count;
  final List<CapsuleModel>? data;

  GetCapsulesResponseModel({
    this.success,
    this.count,
    this.data,
  });

  factory GetCapsulesResponseModel.fromJson(Map<String, dynamic> json) {
    return GetCapsulesResponseModel(
      success: json['success'] as bool?,
      count: json['count'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CapsuleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'count': count,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class CapsuleModel {
  final String? id;
  final String? title;
  final String? message;
  final SenderModel? sender;
  final String? recipientEmail;
  final String? recipientPhone;
  final String? recipientUser;
  final bool? isClaimed;
  final DateTime? openDate;
  final bool? isOpened;
  final List<MediaModel>? media;
  final double? price;
  final String? paymentStatus;
  final bool? notificationSentToUnregistered;
  final bool? notificationSentToRegistered;
  final DateTime? createdAt;
  final int? v;

  CapsuleModel({
    this.id,
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
    this.createdAt,
    this.v,
  });

  factory CapsuleModel.fromJson(Map<String, dynamic> json) {
    return CapsuleModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      sender: json['sender'] != null
          ? SenderModel.fromJson(json['sender'] as Map<String, dynamic>)
          : null,
      recipientEmail: json['recipientEmail'] as String?,
      recipientPhone: json['recipientPhone'] as String?,
      recipientUser: json['recipientUser'] as String?,
      isClaimed: json['isClaimed'] as bool?,
      openDate: json['openDate'] != null
          ? DateTime.tryParse(json['openDate'])
          : null,
      isOpened: json['isOpened'] as bool?,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: (json['price'] as num?)?.toDouble(),
      paymentStatus: json['paymentStatus'] as String?,
      notificationSentToUnregistered:
          json['notificationSentToUnregistered'] as bool?,
      notificationSentToRegistered:
          json['notificationSentToRegistered'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'message': message,
      'sender': sender?.toJson(),
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
      'createdAt': createdAt?.toIso8601String(),
      '__v': v,
    };
  }
}

class SenderModel {
  final String? id;
  final String? name;
  final String? email;

  SenderModel({
    this.id,
    this.name,
    this.email,
  });

  factory SenderModel.fromJson(Map<String, dynamic> json) {
    return SenderModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
    };
  }
}

class MediaModel {
  final String? type;
  final String? url;
  final String? mimetype;
  final int? size;
  final String? id;

  MediaModel({
    this.type,
    this.url,
    this.mimetype,
    this.size,
    this.id,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      type: json['type'] as String?,
      url: json['url'] as String?,
      mimetype: json['mimetype'] as String?,
      size: json['size'] as int?,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
      'mimetype': mimetype,
      'size': size,
      '_id': id,
    };
  }
}
