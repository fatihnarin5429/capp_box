import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';

class PhotoEditorWidget extends StatefulWidget {
  final File photoFile;
  final VoidCallback onClose;
  final VoidCallback onSave;
  final Function(File) onPhotoSaved;

  const PhotoEditorWidget({
    super.key,
    required this.photoFile,
    required this.onClose,
    required this.onSave,
    required this.onPhotoSaved,
  });

  @override
  State<PhotoEditorWidget> createState() => _PhotoEditorWidgetState();
}

class _PhotoEditorWidgetState extends State<PhotoEditorWidget> {
  final GlobalKey _editRepaintKey = GlobalKey();
  final TransformationController _tController = TransformationController();
  BoxFit _fit = BoxFit.cover;
  BoxFit? _prevFit;
  static const double _minScale = 0.9;
  static const double _maxScale = 6.0;
  static const double _aspect = 3 / 4;

  void _resetEditSettings() {
    _fit = BoxFit.cover;
    _prevFit = null;
    _tController.value = Matrix4.identity();
  }

  void _resetTransform() {
    setState(() {
      _tController.value = Matrix4.identity();
      _fit = BoxFit.cover;
      _prevFit = null;
    });
  }

  void _toggleFit() {
    setState(() {
      _prevFit ??= _fit;
      _fit = (_fit == BoxFit.cover) ? BoxFit.contain : BoxFit.cover;
      _tController.value = Matrix4.identity();
    });
  }

  Future<void> _saveEditedPhoto() async {
    try {
      HapticFeedback.mediumImpact();

      final boundary =
          _editRepaintKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) return;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      final bytes = byteData.buffer.asUint8List();
      final path = widget.photoFile.path;
      final editedPath = path.replaceFirst(RegExp(r'\.(\w+)$'), '_edited.png');
      final outFile = File(editedPath);
      await outFile.writeAsBytes(bytes, flush: true);

      widget.onPhotoSaved(outFile);
    } catch (e) {
      // Hata durumunda orijinal dosyayı kullan
      widget.onPhotoSaved(widget.photoFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: _aspect,
            child: RepaintBoundary(
              key: _editRepaintKey,
              child: Container(
                color: Colors.black,
                child: InteractiveViewer(
                  transformationController: _tController,
                  minScale: _minScale,
                  maxScale: _maxScale,
                  child: Image.file(
                    widget.photoFile,
                    fit: _fit,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Üst araç çubuğu
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  IconButton(
                    onPressed: widget.onClose,
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    'Fotoğrafı Düzenle',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _saveEditedPhoto,
                    icon: const Icon(Icons.check, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Sol-alt: Kapla/Sığdır
        Positioned(
          left: 12,
          bottom: 12 + 72,
          child: Material(
            color: Colors.transparent,
            child: IconButton.filled(
              onPressed: _toggleFit,
              icon: const Icon(Icons.open_in_full_rounded),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
              ),
              tooltip: context.tr('fit_toggle') ?? 'Kapla / Sığdır',
            ),
          ),
        ),

        // Sağ-alt: Reset
        Positioned(
          right: 12,
          bottom: 12 + 72,
          child: Material(
            color: Colors.transparent,
            child: IconButton.filled(
              onPressed: _resetTransform,
              icon: const Icon(Icons.refresh_rounded),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
              ),
              tooltip: context.tr('reset') ?? 'Sıfırla',
            ),
          ),
        ),

        // Alt bar: İptal / Kaydet
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            top: false,
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1F36).withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  TextButton(
                    onPressed: widget.onClose,
                    child: Text(context.tr('cancel') ?? 'İptal'),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _saveEditedPhoto,
                    child: Text(context.tr('save') ?? 'Kaydet'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
