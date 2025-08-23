import 'dart:io';
import 'package:flutter/material.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';

class MediaPreviewWidget extends StatelessWidget {
  final File file;
  final String fileName;
  final MediaType type;
  final VoidCallback onEdit;
  final VoidCallback onChange;
  final VoidCallback onRemove;

  const MediaPreviewWidget({
    super.key,
    required this.file,
    required this.fileName,
    required this.type,
    required this.onEdit,
    required this.onChange,
    required this.onRemove,
  });

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

  @override
  Widget build(BuildContext context) {
    final displayName = fileName.isEmpty ? 'Resim' : fileName;
    final isPhoto = type == MediaType.photo;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Medya içeriği
        if (isPhoto)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.file(file, fit: BoxFit.cover),
            ),
          )
        else
          Center(child: Icon(_getMediaIcon(), color: Colors.white, size: 60)),

        // Alt şerit: dosya adı + eylemler
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.0),
                ],
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (isPhoto) ...[
                    _buildActionButton(
                      icon: Icons.edit,
                      label: context.tr('edit') ?? 'Düzenle',
                      onTap: onEdit,
                    ),
                    const SizedBox(width: 8),
                  ],
                  _buildActionButton(
                    icon: Icons.change_circle,
                    label: context.tr('change') ?? 'Değiştir',
                    onTap: onChange,
                  ),
                  const SizedBox(width: 8),
                  _buildActionButton(
                    icon: Icons.delete,
                    label: context.tr('remove') ?? 'Kaldır',
                    onTap: onRemove,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
