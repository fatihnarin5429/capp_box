// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/capsule_progress_bar.dart';
import '../widgets/media_preview.dart';
import '../widgets/info_sharing_options.dart';
import '../widgets/sms_notification_options.dart';
import '../widgets/capsule_success_dialog.dart';
import '../widgets/receiver_info.dart';
import '../widgets/capsule_date_info.dart';
import '../widgets/capsule_title.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/page_title.dart';

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

class _CapsuleReviewState extends State<CapsuleReview> {
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
                        horizontal: 24, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: BackButtonWidget(),
                            ),
                            PageTitle(title: 'Gözden Geçir'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: CapsuleProgressBar(
                              currentStep: widget.currentStep),
                        ),
                        CapsuleTitle(
                          state: state,
                        ),
                        MediaPreview(
                          type: state.createCapsuleModel.mediaType ??
                              MediaType.text,
                          photoFile: state.createCapsuleModel.mediaUrl,
                          audioFile: state.createCapsuleModel.mediaType ==
                                  MediaType.voice
                              ? state.createCapsuleModel.mediaUrl
                              : widget.audioFile,
                          videoFile: state.createCapsuleModel.mediaType ==
                                  MediaType.video
                              ? state.createCapsuleModel.mediaUrl
                              : widget.videoFile,
                          selectedFileName:
                              state.createCapsuleModel.mediaType ==
                                      MediaType.voice
                                  ? state.createCapsuleModel.mediaUrl?.path
                                  : widget.selectedFileName,
                        ),
                        ReceiverInfo(state: state),
                        CapsuleDateInfo(state: state),
                        InfoSharingOptions(
                          shareInfo: _shareInfo,
                          onShareInfoChanged: (value) =>
                              setState(() => _shareInfo = value),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SMSNotificationOptions(
                                sendSMS: _sendSMS,
                                onSendSMSChanged: (value) =>
                                    setState(() => _sendSMS = value),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.read<CreateCapsuleBloc>().add(
                                              CreateCapsuleAction(
                                                createCapsuleModel: state
                                                    .createCapsuleModel
                                                    .copyWith(
                                                  isSendInfoReceiver:
                                                      _shareInfo,
                                                  isSendInfoSms: _sendSMS,
                                                ),
                                              ),
                                            );
                                      },
                                      child: const Text(
                                        'Taslak Olarak Kaydet',
                                        style: TextStyle(
                                          color: Color(0xFF84858E),
                                          fontSize: 14,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.read<CreateCapsuleBloc>().add(
                                              CreateCapsuleAction(
                                                createCapsuleModel: state
                                                    .createCapsuleModel
                                                    .copyWith(
                                                  isSendInfoReceiver:
                                                      _shareInfo,
                                                  isSendInfoSms: _sendSMS,
                                                ),
                                              ),
                                            );
                                        CapsuleSuccessDialog.show(context);
                                      },
                                      child: Container(
                                        width: 162,
                                        height: 56,
                                        decoration: ShapeDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFB224EF),
                                              Color(0xFF7579FF)
                                            ],
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Gönder',
                                            style: TextStyle(
                                              color: Color(0xFFE5E5E5),
                                              fontSize: 14,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w700,
                                              height: 1.70,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
}
