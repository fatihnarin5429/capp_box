import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/create_capsul/view/create_capsul_3_view..dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';

import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/page_title.dart';
import '../widgets/step_indicator.dart';
import '../widgets/continue_button.dart';
import '../widgets/media_selector_button.dart';
import '../mixins/media_mixin.dart';
import '../widgets/selected_media_preview.dart';

class CreateCapsul2View extends StatefulWidget {
  final TextEditingController controller;
  final bool autofocus;
  final bool isPassword;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final TextStyle? style;
  final Widget? prefix;
  final String? labelText;
  final String? hintText;
  final bool isError;
  final String? errorText;
  final MediaType? type;
  final String? email;
  const CreateCapsul2View({
    super.key,
    required this.controller,
    this.autofocus = false,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.style,
    this.prefix,
    this.labelText,
    this.hintText,
    this.isError = false,
    this.errorText,
    required this.type,
    this.email,
  });

  @override
  State<CreateCapsul2View> createState() => _CreateCapsul2ViewState();
}

class _CreateCapsul2ViewState extends State<CreateCapsul2View> with MediaMixin {
  bool hasText = false;
  final int currentStep = 0;
  File? photoFile;
  File? videoFile;
  File? audioFile;
  String? email;
  String? selectedFileName;
  VideoPlayerController? _videoPlayerController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkPermissions(widget.type);
    if (videoFile != null) {
      _initializeVideoPlayer();
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    if (videoFile != null) {
      _videoPlayerController = VideoPlayerController.file(videoFile!)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: BlocBuilder<CreateCapsuleBloc, CreateCapsuleState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: BackButtonWidget(),
                            ),
                            const PageTitle(title: 'Kapsül Oluştur'),
                          ],
                        ),

                        // Progress indicator
                        StepIndicator(currentStep: currentStep),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Başlık Ekleyin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          onChanged: (value) {},
                          hintText: 'Başlık',
                          controller: _titleController,
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(height: 24),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Mesajınız',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          textInputType: TextInputType.text,
                          controller: _messageController,
                          hintText: widget.hintText ?? 'Mesajınızı yazın...',
                          maxLines: null,
                          height: 278,
                          onChanged: (value) {
                            setState(() {
                              hasText = value.isNotEmpty;
                            });
                            widget.onChanged(value);
                          },
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.type == MediaType.text
                                ? 'Yazı Ekle'
                                : widget.type == MediaType.voice
                                    ? "Ses Ekle"
                                    : "Medya Ekle",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                        widget.type == MediaType.photo
                            ? const SizedBox()
                            : const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Yüklemek istediğiniz videoyu seçiniz',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w400,
                                    height: 1.70,
                                    letterSpacing: -0.50,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 12),
                        MediaSelectorButton(
                          type: widget.type!,
                          onTap: () {
                            if (widget.type == MediaType.photo) {
                              pickImage(
                                  (file) => setState(() => photoFile = file));
                            } else if (widget.type == MediaType.video) {
                              pickVideo((file) => setState(() {
                                    videoFile = file;
                                    _initializeVideoPlayer();
                                  }));
                            } else if (widget.type == MediaType.voice) {
                              pickAudioFile(
                                  context,
                                  (file, name) => setState(() {
                                        audioFile = file;
                                        selectedFileName = name;
                                      }));
                            }
                          },
                        ),
                        SelectedMediaPreview(
                          type: widget.type!,
                          photoFile: photoFile,
                          videoFile: videoFile,
                          audioFile: audioFile,
                          selectedFileName: selectedFileName,
                          videoPlayerController: _videoPlayerController,
                          onRemovePhoto: () => setState(() => photoFile = null),
                          onRemoveVideo: () => setState(() {
                            videoFile = null;
                            _videoPlayerController?.dispose();
                            _videoPlayerController = null;
                          }),
                          onRemoveAudio: () => setState(() {
                            audioFile = null;
                            selectedFileName = null;
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: ContinueButton(
                            displayNameController: TextEditingController(),
                            mailController: TextEditingController(),
                            phoneController: TextEditingController(),
                            videoFile: videoFile,
                            photoFile: photoFile,
                            audioFile: audioFile,
                            type: widget.type!,
                            selectedFileName: selectedFileName,
                            secilenTip: widget.type!,
                            onPressed: () {
                              context.read<CreateCapsuleBloc>().add(
                                    CreateCapsuleAction(
                                      createCapsuleModel: CreateCapsuleModel(
                                        title: _titleController.text,
                                        message: _messageController.text,
                                        mediaType: widget.type!,
                                        mediaUrl: widget.type == MediaType.photo
                                            ? photoFile
                                            : widget.type == MediaType.video
                                                ? videoFile
                                                : audioFile,
                                      ),
                                    ),
                                  );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateCapsul3View(
                                    controller: _titleController,
                                    onChanged: widget.onChanged,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
