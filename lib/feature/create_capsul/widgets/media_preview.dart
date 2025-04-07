import 'dart:io';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import '../widgets/review_container.dart';

class MediaPreview extends StatefulWidget {
  final MediaType type;
  final File? photoFile;
  final File? audioFile;
  final File? videoFile;
  final String? selectedFileName;

  const MediaPreview({
    Key? key,
    required this.type,
    this.photoFile,
    this.audioFile,
    this.videoFile,
    this.selectedFileName,
  }) : super(key: key);

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  VideoPlayerController? _videoPlayerController;
  bool isPlaying = false;

  @override
  void initState() {
    _initializeVideoPlayer();
    super.initState();
  }

  Future<void> _initializeVideoPlayer() async {
    if (widget.videoFile != null) {
      _videoPlayerController = VideoPlayerController.file(widget.videoFile!)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.type == MediaType.text ? 8 : 24),
      child: widget.type != MediaType.text
          ? ReviewContainer(
              width: 340,
              padding: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: widget.type == MediaType.photo &&
                            widget.photoFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              widget.photoFile!,
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          )
                        : widget.type != MediaType.text &&
                                context
                                        .read<CreateCapsuleBloc>()
                                        .state
                                        .createCapsuleModel
                                        .mediaType ==
                                    MediaType.voice
                            ? _buildAudioPreview()
                            : _videoPlayerController != null &&
                                    _videoPlayerController!.value.isInitialized
                                ? _buildVideoPreview()
                                : const Center(
                                    child: CircularProgressIndicator()),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildAudioPreview() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black.withOpacity(0.3),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Container(
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
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ses Dosyası',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ses dosyası seçildi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPreview() {
    return InkWell(
      onTap: () {
        if (!isPlaying) {
          setState(() {
            isPlaying = true;
            _videoPlayerController!.play();
          });
        } else {
          setState(() {
            isPlaying = false;
            _videoPlayerController!.pause();
          });
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(
                _videoPlayerController!..setLooping(true),
              ),
            ),
          ),
          Icon(
            size: 48,
            isPlaying ? null : Icons.play_arrow,
          ),
        ],
      ),
    );
  }
}
