import 'package:flutter/material.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';

class EmptyMediaStateWidget extends StatelessWidget {
  final MediaType type;

  const EmptyMediaStateWidget({super.key, required this.type});

  IconData _getMediaIcon() {
    switch (type) {
      case MediaType.photo:
        return Icons.photo;
      case MediaType.video:
        return Icons.videocam;
      case MediaType.voice:
        return Icons.mic;
      case MediaType.text:
        return Icons.text_fields;
    }
  }

  String _getCtaText() {
    switch (type) {
      case MediaType.photo:
        return 'Fotoğraf Seç';
      case MediaType.video:
        return 'Video Seç';
      case MediaType.voice:
        return 'Ses Seç';
      case MediaType.text:
        return 'Metin Yaz';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(_getMediaIcon(), color: Colors.white, size: 40),
          ),
          const SizedBox(height: 20),
          Text(
            _getCtaText(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr('tap_to_select') ?? 'Seçmek için dokunun',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
