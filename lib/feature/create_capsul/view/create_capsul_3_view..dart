import 'dart:io';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/feature/create_capsul/view/time_capsule_history_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButtonWidget(),
                        Expanded(
                          child: PageTitle(title: 'Kapsül Oluştur'),
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
        const Text(
          'Ad Soyad',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _displayNameController,
          hintText: 'Ad Soyad',
          onChanged: (value) {},
          textInputType: TextInputType.name,
        ),
        const SizedBox(height: 24),
        const Text(
          'Mail Adresi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _mailController,
          hintText: 'Mail Adresi',
          onChanged: (value) {},
          textInputType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        const Text(
          'Telefon Numarası',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _phoneController,
          hintText: 'Telefon Numarası',
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
            builder: (context) => TimeCapsuleHistoryView(
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
