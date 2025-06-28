import 'dart:io';

import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/create_capsul/view/create_capsul_information_view.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';

import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/page_title.dart';
import '../widgets/step_indicator.dart';
import '../widgets/continue_button.dart';
import '../widgets/media_selector_button.dart';
import '../mixins/media_mixin.dart';
import '../widgets/selected_media_preview.dart';
import 'package:capp_box/feature/profile/widgets/file_validator.dart';

class CreateCapsulContentView extends StatefulWidget {
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
  const CreateCapsulContentView({
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
  State<CreateCapsulContentView> createState() =>
      _CreateCapsulContentViewState();
}

class _CreateCapsulContentViewState extends State<CreateCapsulContentView>
    with MediaMixin {
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
  int currentVideoCount = 0;
  int currentImageCount = 0;
  int currentAudioCount = 0;

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
    _titleController.dispose();
    _messageController.dispose();
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

  Future<void> pickAndValidateFile(
    BuildContext context,
    String sourceType,
  ) async {
    File? selectedFile;

    try {
      if (sourceType == 'image') {
        final XFile? image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) selectedFile = File(image.path);
      } else if (sourceType == 'video') {
        final XFile? video = await ImagePicker().pickVideo(
          source: ImageSource.gallery,
        );
        if (video != null) selectedFile = File(video.path);
      } else if (sourceType == 'audio') {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.audio,
          allowMultiple: false,
        );
        if (result != null && result.files.isNotEmpty) {
          selectedFile = File(result.files.first.path!);
        }
      }

      if (selectedFile == null) return;

      final fileType = FileValidator.determineFileType(selectedFile);

      if (fileType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.tr('unsupported_file_type'))),
        );
        return;
      }

      if (!FileValidator.validateFileSize(selectedFile, context) ||
          !FileValidator.validateFileType(selectedFile, fileType, context) ||
          !FileValidator.validateFileCount(
            fileType,
            fileType == 'video'
                ? currentVideoCount
                : fileType == 'image'
                ? currentImageCount
                : currentAudioCount,
            context,
          )) {
        return;
      }

      if (fileType == 'video') {
        currentVideoCount++;
        setState(() {
          videoFile = selectedFile;
          _initializeVideoPlayer();
        });
      } else if (fileType == 'image') {
        currentImageCount++;
        setState(() {
          photoFile = selectedFile;
        });
      } else if (fileType == 'audio') {
        currentAudioCount++;
        setState(() {
          audioFile = selectedFile;
          selectedFileName = FileValidator.extractFileName(selectedFile!);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.tr('file_selection_error'))),
      );
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
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: BackButtonWidget(),
                            ),
                            PageTitle(title: context.tr('create_capsule')),
                          ],
                        ),

                        // Progress indicator
                        StepIndicator(currentStep: currentStep),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            context.tr('add_title'),
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
                          hintText: context.tr('title'),
                          controller: _titleController,
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            context.tr('message'),
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
                          hintText: context.tr('message'),
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
                                ? context.tr('add_text')
                                : widget.type == MediaType.voice
                                ? context.tr('add_voice')
                                : context.tr('add_media'),
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
                            : Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                context.tr('select_video'),
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
                              pickAndValidateFile(context, 'image');
                            } else if (widget.type == MediaType.video) {
                              pickAndValidateFile(context, 'video');
                            } else if (widget.type == MediaType.voice) {
                              pickAndValidateFile(context, 'audio');
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
                          onRemoveVideo:
                              () => setState(() {
                                videoFile = null;
                                _videoPlayerController?.dispose();
                                _videoPlayerController = null;
                              }),
                          onRemoveAudio:
                              () => setState(() {
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
                                    mediaUrl:
                                        widget.type == MediaType.photo
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
                                  builder:
                                      (context) => CreateCapsulInformationView(
                                        controller: _titleController,
                                        onChanged: widget.onChanged,
                                      ),
                                ),
                              );
                              print(
                                'state1: ${state.myCreatedCapsules} and ${state.createCapsuleModel}',
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
