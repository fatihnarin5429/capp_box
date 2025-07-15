class Capsule {
  final String id;
  final String title;
  final String content;
  final DateTime creationDate;
  final DateTime openingDate;
  final String mediaType;
  final String mediaUrl;
  final bool isOpened;
  final String openDate;

  Capsule({
    required this.id,
    required this.title,
    required this.content,
    required this.creationDate,
    required this.openingDate,
    required this.mediaType,
    this.mediaUrl = '',
    this.isOpened = false,
    required this.openDate,
  });

  String get displayName => title;
  String get openedDate => openingDate.toIso8601String();

  Capsule copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? creationDate,
    DateTime? openingDate,
    String? mediaType,
    String? mediaUrl,
    bool? isOpened,
    String? openDate,
  }) {
    return Capsule(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      creationDate: creationDate ?? this.creationDate,
      openingDate: openingDate ?? this.openingDate,
      mediaType: mediaType ?? this.mediaType,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      isOpened: isOpened ?? this.isOpened,
      openDate: openDate ?? this.openDate,
    );
  }

  factory Capsule.fromJson(Map<String, dynamic> json) {
    return Capsule(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
      openingDate: DateTime.parse(json['openingDate'] as String),
      mediaType: json['mediaType'] as String,
      mediaUrl: json['mediaUrl'] as String? ?? '',
      isOpened: json['isOpened'] as bool? ?? false,
      openDate: json['openDate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'creationDate': creationDate.toIso8601String(),
      'openingDate': openingDate.toIso8601String(),
      'mediaType': mediaType,
      'mediaUrl': mediaUrl,
      'isOpened': isOpened,
      'openDate': openDate,
    };
  }
}

class CapsuleData {
  final String? openDate;
  final Capsule? capsule;

  CapsuleData({this.openDate, this.capsule});

  CapsuleData copyWith({String? openDate, Capsule? capsule}) {
    return CapsuleData(
      openDate: openDate ?? this.openDate,
      capsule: capsule ?? this.capsule,
    );
  }

  factory CapsuleData.fromJson(Map<String, dynamic> json) {
    return CapsuleData(
      openDate: json['openDate'] as String?,
      capsule:
          json['capsule'] != null
              ? Capsule.fromJson(json['capsule'] as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'openDate': openDate, 'capsule': capsule?.toJson()};
  }
}
