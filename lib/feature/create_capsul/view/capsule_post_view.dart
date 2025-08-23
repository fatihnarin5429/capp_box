import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';
import 'package:capp_box/feature/create_capsul/widgets/continue_button.dart';
import 'package:capp_box/feature/create_capsul/widgets/step_indicator.dart';
import 'package:capp_box/feature/create_capsul/widgets/photo_editor_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/text_editor_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/media_preview_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/empty_media_state_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/loading_overlay_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/media_section_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/disabled_continue_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/capsule_header_widget.dart';
import 'package:capp_box/feature/create_capsul/view/create_capsul_information_view.dart';

class CapsulePostView extends StatefulWidget {
  final MediaType type;
  final int currentStep;
  final Function(
    File? photoFile,
    File? videoFile,
    File? audioFile,
    String? fileName,
  )
  onMediaSelected;

  const CapsulePostView({
    super.key,
    required this.type,
    required this.currentStep,
    required this.onMediaSelected,
  });

  @override
  State<CapsulePostView> createState() => _CapsulePostViewState();
}

class _CapsulePostViewState extends State<CapsulePostView> {
  File? _selectedFile;
  String? _selectedFileName;
  bool _isLoading = false;

  // --- Düzenleme durumları ---
  bool _isEditingPhoto = false;
  bool _isEditingText = false;
  final TextEditingController _textController = TextEditingController();

  bool get _hasMedia =>
      _selectedFile != null ||
      (widget.type == MediaType.text && _textController.text.isNotEmpty);

  // ===== Helpers =====
  String _titleKey() {
    switch (widget.type) {
      case MediaType.photo:
        return 'photo_selection';
      case MediaType.video:
        return 'video_selection';
      case MediaType.voice:
        return 'audio_selection';
      case MediaType.text:
        return 'text_selection';
    }
  }

  // ===== Pickers =====
  Future<void> _pickMedia() async {
    if (widget.type == MediaType.text) {
      setState(() => _isEditingText = true);
      return;
    }

    try {
      setState(() => _isLoading = true);
      await _pickFile();
    } catch (e) {
      BotToast.showText(
        text:
            '${context.tr('file_selection_error') ?? 'Dosya seçilirken bir hata oluştu'}: $e',
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    dynamic result;

    switch (widget.type) {
      case MediaType.photo:
        result = await picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 1920,
          maxHeight: 1920,
          imageQuality: 90,
        );
        break;
      case MediaType.video:
        result = await picker.pickVideo(
          source: ImageSource.gallery,
          maxDuration: const Duration(minutes: 10),
        );
        break;
      case MediaType.voice:
        final fileResult = await FilePicker.platform.pickFiles(
          type: FileType.audio,
          allowMultiple: false,
        );
        result = fileResult?.files.single;
        break;
      case MediaType.text:
        return;
    }

    if (result == null) return;

    setState(() {
      if (widget.type == MediaType.voice) {
        _selectedFile = File(result.path!);
        _selectedFileName = result.name;
      } else {
        _selectedFile = File(result.path);
        _selectedFileName = result.name;
      }
      if (widget.type == MediaType.photo) {
        _enterEditMode();
      }
    });
  }

  void _enterEditMode() {
    setState(() {
      _isEditingPhoto = true;
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedFile = null;
      _selectedFileName = null;
      _isEditingPhoto = false;
      _isEditingText = false;
    });
  }

  void _onPhotoSaved(File editedFile) {
    setState(() {
      _selectedFile = editedFile;
      _selectedFileName = editedFile.path.split('/').last;
      _isEditingPhoto = false;
    });
    BotToast.showText(text: context.tr('photo_saved') ?? 'Fotoğraf kaydedildi');
  }

  void _onTextSaved() {
    setState(() {
      _isEditingText = false;
    });
  }

  void _onContinue() {
    if (!_hasMedia || _isEditingPhoto || _isEditingText) return;

    HapticFeedback.lightImpact();

    final fileName =
        widget.type == MediaType.text
            ? _textController.text
            : _selectedFileName;

    widget.onMediaSelected(
      widget.type == MediaType.photo ? _selectedFile : null,
      widget.type == MediaType.video ? _selectedFile : null,
      widget.type == MediaType.voice ? _selectedFile : null,
      fileName,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => CreateCapsulInformationView(
              controller:
                  widget.type == MediaType.text
                      ? _textController
                      : TextEditingController(),
              onChanged: (_) {},
              videoFile: widget.type == MediaType.video ? _selectedFile : null,
              photoFile: widget.type == MediaType.photo ? _selectedFile : null,
              audioFile: widget.type == MediaType.voice ? _selectedFile : null,
              type: widget.type,
              selectedFileName: fileName,
            ),
      ),
    );
  }

  // ===== UI =====
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CapsuleHeaderWidget(type: widget.type),
                    StepIndicator(currentStep: widget.currentStep),
                    const SizedBox(height: 24),
                    MediaSectionWidget(
                      onTap: _pickMedia,
                      isDisabled:
                          _isLoading || _isEditingPhoto || _isEditingText,
                      child: _buildMediaContent(),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    if (!_isEditingPhoto && !_isEditingText)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ContinueButton(onPressed: _onContinue),
                      ),
                  ],
                ),
              ),
            ),
          ),

          if (_isLoading) const LoadingOverlayWidget(),
        ],
      ),
    );
  }

  Widget _buildMediaContent() {
    if (widget.type == MediaType.text) {
      return TextEditorWidget(
        controller: _textController,
        onClose: () => setState(() => _isEditingText = false),
        onSave: _onTextSaved,
      );
    }

    if (_selectedFile == null) return EmptyMediaStateWidget(type: widget.type);

    if (widget.type == MediaType.photo && _isEditingPhoto) {
      return PhotoEditorWidget(
        photoFile: _selectedFile!,
        onClose: () => setState(() => _isEditingPhoto = false),
        onSave: () {},
        onPhotoSaved: _onPhotoSaved,
      );
    }

    return MediaPreviewWidget(
      file: _selectedFile!,
      fileName: _selectedFileName ?? '',
      type: widget.type,
      onEdit: () => setState(() => _isEditingPhoto = true),
      onChange: _pickMedia,
      onRemove: _clearSelection,
    );
  }
}
