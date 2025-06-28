// lib/feature/create_capsul/mixin/capsule_review_mixin.dart

import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/view/capsule_buy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/create_capsule_bloc.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/page_title.dart';
import '../widgets/capsule_progress_bar.dart';
import '../widgets/sms_notification_options.dart';
import '../widgets/capsule_success_dialog.dart';

/// A mixin that provides UI components and functionality for the Capsule Review screen.
///
/// This mixin encapsulates common UI elements and business logic related to
/// capsule review, making the main widget more focused and maintainable.
mixin CapsuleReviewMixin<T extends StatefulWidget> on State<T> {
  /// Builds the header section with back button and page title
  Widget buildHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(alignment: Alignment.centerLeft, child: BackButtonWidget()),
        PageTitle(title: context.tr('Review', args: {})),
      ],
    );
  }

  /// Builds the progress bar indicating the current step
  Widget buildProgressBar(int currentStep) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: CapsuleProgressBar(currentStep: currentStep),
    );
  }

  /// Builds the notification options section including SMS settings and action buttons
  Widget buildNotificationOptions({
    required CreateCapsuleState state,
    required bool shareInfo,
    required bool sendSMS,
    required ValueChanged<bool> onShareInfoChanged,
    required ValueChanged<bool> onSendSMSChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SMSNotificationOptions(
            sendSMS: sendSMS,
            onSendSMSChanged: onSendSMSChanged,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSaveDraftButton(state, shareInfo, sendSMS),
                _buildSendButton(state, shareInfo, sendSMS),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Creates a button to save the capsule as a draft
  Widget _buildSaveDraftButton(
    CreateCapsuleState state,
    bool shareInfo,
    bool sendSMS,
  ) {
    return InkWell(
      onTap: () => _handleCreateCapsuleAction(state, shareInfo, sendSMS),
      child: Text(
        context.tr('save_draft'),
        style: const TextStyle(
          color: Color(0xFF84858E),
          fontSize: 14,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// Creates a button to send the capsule
  Widget _buildSendButton(
    CreateCapsuleState state,
    bool shareInfo,
    bool sendSMS,
  ) {
    return GestureDetector(
      onTap: () {
        _handleCreateCapsuleAction(state, shareInfo, sendSMS);
        CapsuleSuccessDialog.show(context);

        // CapsuleSuccessDialog gösterildikten sonra CapsuleView'a yönlendirilecek
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const CapsuleBuyView()),
          (route) => false, // Tüm navigasyon geçmişini temizle
        );
      },
      child: Container(
        width: 162,
        height: 56,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Center(
          child: Text(
            context.tr('send'),
            style: const TextStyle(
              color: Color(0xFFE5E5E5),
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
              height: 1.70,
            ),
          ),
        ),
      ),
    );
  }

  /// Handles the action of creating or updating a capsule
  void _handleCreateCapsuleAction(
    CreateCapsuleState state,
    bool shareInfo,
    bool sendSMS,
  ) {
    context.read<CreateCapsuleBloc>().add(
      CreateCapsuleAction(
        createCapsuleModel: state.createCapsuleModel.copyWith(
          isSendInfoReceiver: shareInfo,
          isSendInfoSms: sendSMS,
        ),
      ),
    );
  }
}
