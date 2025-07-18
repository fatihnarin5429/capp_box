// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/mixin/capsule_review_mixin.dart';

import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/media_preview.dart';
import '../widgets/info_sharing_options.dart';
import '../widgets/receiver_info.dart';
import '../widgets/capsule_date_info.dart';
import '../widgets/capsule_title.dart';

class CapsuleReview extends StatefulWidget {
  final int currentStep;
  final File? videoFile;
  final File? photoFile;
  final File? audioFile;
  final MediaType? type;
  final String? selectedFileName;
  final String? email;
  const CapsuleReview({
    Key? key,
    this.currentStep = 3,
    this.videoFile,
    this.photoFile,
    this.audioFile,
    this.type,
    this.selectedFileName,
    this.email,
  }) : super(key: key);

  @override
  State<CapsuleReview> createState() => _CapsuleReviewState();
}

class _CapsuleReviewState extends State<CapsuleReview> with CapsuleReviewMixin {
  bool _shareInfo = true;
  bool _sendSMS = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CreateCapsuleBloc, CreateCapsuleState>(
        builder: (context, state) {
          return Stack(
            children: [
              const BackgroundGradient(),
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHeader(),
                        buildProgressBar(widget.currentStep),
                        _buildCapsuleContent(state),
                        buildNotificationOptions(
                          state: state,
                          shareInfo: _shareInfo,
                          sendSMS: _sendSMS,
                          onShareInfoChanged:
                              (value) => setState(() => _shareInfo = value),
                          onSendSMSChanged:
                              (value) => setState(() => _sendSMS = value),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Builds the main content of the capsule including title, media, receiver info, etc.
  Widget _buildCapsuleContent(CreateCapsuleState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CapsuleTitle(
          title: state.createCapsuleResponseModel.data.capsule.title,
          state: state,
        ),
        MediaPreview(
          type: state.createCapsuleResponseModel.data.capsule.mediaType,
          photoFile: _getPhotoFile(state),
          audioFile: _getAudioFile(state),
          videoFile: _getVideoFile(state),
          selectedFileName: widget.selectedFileName,
        ),
        ReceiverInfo(state: state),
        CapsuleDateInfo(state: state),
        InfoSharingOptions(
          shareInfo: _shareInfo,
          onShareInfoChanged: (value) => setState(() => _shareInfo = value),
        ),
      ],
    );
  }

  dynamic _getPhotoFile(CreateCapsuleState state) {
    if (state.createCapsuleResponseModel.data.capsule.mediaType ==
        MediaType.photo) {
      return widget.photoFile ??
          (state.createCapsuleResponseModel.data.capsule.mediaUrl != null
              ? File(state.createCapsuleResponseModel.data.capsule.mediaUrl!)
              : null);
    }
    return widget.photoFile;
  }

  dynamic _getAudioFile(CreateCapsuleState state) {
    if (state.createCapsuleResponseModel.data.capsule.mediaType ==
        MediaType.voice) {
      return widget.audioFile ??
          (state.createCapsuleResponseModel.data.capsule.mediaUrl != null
              ? File(state.createCapsuleResponseModel.data.capsule.mediaUrl!)
              : null);
    }
    return widget.audioFile;
  }

  dynamic _getVideoFile(CreateCapsuleState state) {
    if (state.createCapsuleResponseModel.data.capsule.mediaType ==
        MediaType.video) {
      return widget.videoFile ??
          state.createCapsuleResponseModel.data.capsule.mediaUrl;
    }
    return widget.videoFile;
  }
}
