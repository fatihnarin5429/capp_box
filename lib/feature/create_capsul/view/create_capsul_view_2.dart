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

class _CreateCapsul2ViewState extends State<CreateCapsul2View> {
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
    _checkPermissions();
    if (videoFile != null) {
      _initializeVideoPlayer();
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }

      if (widget.type == MediaType.voice) {
        if (await Permission.audio.isDenied) {
          await Permission.audio.request();
        }
      } else if (widget.type == MediaType.photo ||
          widget.type == MediaType.video) {
        if (await Permission.camera.isDenied) {
          await Permission.camera.request();
        }
      }
    }
  }

  Future<void> _initializeVideoPlayer() async {
    if (videoFile != null) {
      _videoPlayerController = VideoPlayerController.file(videoFile!)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  Future<void> _pickAudioFile() async {
    final context = this.context;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowCompression: false,
        withData: true,
        dialogTitle: 'Ses Dosyası Seç',
        allowedExtensions: [
          'mp3',
          'mp4',
          'mpeg',
          'mpga',
          'webm',
          'wav',
          'm4a',
          'aac',
        ],
      );

      if (!mounted) return;

      if (result != null &&
          result.files.isNotEmpty &&
          result.files.single.path != null) {
        setState(() {
          audioFile = File(result.files.single.path!);
          selectedFileName = result.files.single.name;
        });
        BotToast.showText(
            text: 'Ses dosyası başarıyla seçildi', contentColor: Colors.green);
      }
    } catch (e) {
      if (!mounted) return;

      print('Ses dosyası seçme hatası: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Ses dosyası seçilirken bir hata oluştu: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          photoFile = File(image.path);
        });
      }
    } catch (e) {
      print('Resim seçme hatası: $e');
    }
  }

  Future<void> _pickVideo() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

      if (video != null) {
        setState(() {
          videoFile = File(video.path);
          _initializeVideoPlayer();
        });
      }
    } catch (e) {
      print('Video seçme hatası: $e');
    }
  }

  Widget _buildSelectedMediaPreview() {
    if (widget.type == MediaType.photo && photoFile != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                photoFile!,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.grey.withOpacity(0.3),
                    child: const Center(
                      child: Text(
                        'Resim yüklenemedi',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    photoFile = null;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (widget.type == MediaType.video && videoFile != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withOpacity(0.3),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            if (_videoPlayerController != null &&
                _videoPlayerController!.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    videoFile = null;
                    _videoPlayerController?.dispose();
                    _videoPlayerController = null;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (widget.type == MediaType.voice && audioFile != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withOpacity(0.3),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA737FF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.audiotrack, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ses Dosyası',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          selectedFileName ?? 'Ses dosyası seçildi',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontFamily: 'Urbanist',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    audioFile = null;
                    selectedFileName = null;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
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
                        widget.type == MediaType.text
                            ? const SizedBox()
                            : MediaSelectorButton(
                                type: widget.type,
                                onTap: () {
                                  if (widget.type == MediaType.photo) {
                                    _pickImage();
                                  } else if (widget.type == MediaType.video) {
                                    _pickVideo();
                                  } else if (widget.type == MediaType.voice) {
                                    _pickAudioFile();
                                  }
                                },
                              ),
                        _buildSelectedMediaPreview(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: ContinueButton(
                            displayNameController: TextEditingController(),
                            mailController: TextEditingController(),
                            phoneController: TextEditingController(),
                            videoFile: videoFile,
                            photoFile: photoFile,
                            audioFile: audioFile,
                            type: widget.type,
                            selectedFileName: selectedFileName,
                            secilenTip: widget.type,
                            onPressed: () {
                              context.read<CreateCapsuleBloc>().add(
                                    CreateCapsuleAction(
                                      createCapsuleModel: CreateCapsuleModel(
                                        title: _titleController.text,
                                        message: _messageController.text,
                                        mediaType: widget.type,
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
