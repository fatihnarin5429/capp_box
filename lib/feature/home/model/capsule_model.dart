class Capsule {
  final String id;
  final String title;
  final String content;
  final DateTime creationDate;
  final DateTime openingDate;
  final String mediaType; // yazı, video, ses, fotoğraf
  final String mediaUrl;
  final bool isOpened;

  Capsule({
    required this.id,
    required this.title,
    required this.content,
    required this.creationDate,
    required this.openingDate,
    required this.mediaType,
    this.mediaUrl = '',
    this.isOpened = false,
  });

  factory Capsule.fromJson(Map<String, dynamic> json) {
    return Capsule(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      creationDate: DateTime.parse(json['creationDate']),
      openingDate: DateTime.parse(json['openingDate']),
      mediaType: json['mediaType'],
      mediaUrl: json['mediaUrl'] ?? '',
      isOpened: json['isOpened'] ?? false,
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
    };
  }
}
