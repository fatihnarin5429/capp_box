import 'dart:io';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/feature/create_capsul/view/time_capsule_history_view.dart';
import 'package:capp_box/feature/create_capsul/widgets/step_indicator.dart';
import 'package:capp_box/feature/create_capsul/widgets/continue_button.dart';

class CreateCapsul3View extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final Function(String) onChanged;
  final int currentStep;
  final File? videoFile;
  final File? photoFile;
  final File? audioFile;
  final MediaType? type;
  final String? selectedFileName;

  const CreateCapsul3View({
    Key? key,
    required this.controller,
    this.hintText,
    required this.onChanged,
    this.currentStep = 1,
    this.videoFile,
    this.photoFile,
    this.audioFile,
    this.type,
    this.selectedFileName,
  }) : super(key: key);

  @override
  State<CreateCapsul3View> createState() => _CreateCapsul3ViewState();
}

class _CreateCapsul3ViewState extends State<CreateCapsul3View> {
  bool hasText = false;
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _displayNameController.dispose();
    _mailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const BackButtonWidget(),
                        Expanded(
                          child: PageTitle(title: context.tr('create_capsule')),
                        ),
                      ],
                    ),
                    _buildStepIndicator(),
                    _buildFormFields(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    _buildContinueButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return StepIndicator(currentStep: widget.currentStep);
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('recipient_info'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
            height: 1.40,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          context.tr('name_surname'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _displayNameController,
          hintText: context.tr('name_surname'),
          onChanged: (value) {},
          textInputType: TextInputType.name,
        ),
        const SizedBox(height: 24),
        Text(
          context.tr('email_address'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _mailController,
          hintText: context.tr('email_address'),
          onChanged: (value) {},
          textInputType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        Text(
          context.tr('phone_number'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _phoneController,
          hintText: context.tr('phone_number'),
          onChanged: (value) {},
          textInputType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return ContinueButton(
      displayNameController: _displayNameController,
      mailController: _mailController,
      phoneController: _phoneController,
      videoFile: widget.videoFile,
      photoFile: widget.photoFile,
      audioFile: widget.audioFile,
      type: widget.type,
      selectedFileName: widget.selectedFileName,
      secilenTip: widget.type,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => TimeCapsuleHistoryView(
                  videoFile: widget.videoFile,
                  photoFile: widget.photoFile,
                  audioFile: widget.audioFile,
                  type: widget.type,
                  selectedFileName: widget.selectedFileName,
                ),
          ),
        );
      },
    );
  }
}
