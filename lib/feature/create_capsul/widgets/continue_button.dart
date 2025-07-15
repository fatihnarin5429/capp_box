import 'dart:io';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';

class ContinueButton extends StatelessWidget {
  final TextEditingController displayNameController;
  final TextEditingController mailController;
  final TextEditingController phoneController;
  final File? videoFile;
  final File? photoFile;
  final File? audioFile;
  final MediaType? type;
  final String? selectedFileName;
  final MediaType? secilenTip;
  final VoidCallback onPressed;
  final String? text;
  const ContinueButton({
    Key? key,
    required this.displayNameController,
    required this.mailController,
    required this.phoneController,
    this.videoFile,
    this.photoFile,
    this.audioFile,
    this.type,
    this.selectedFileName,
    required this.secilenTip,
    required this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: SizedBox(
        width: 350,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            context.read<CreateCapsuleBloc>().add(
              CreateCapsuleAction(
                context
                    .read<CreateCapsuleBloc>()
                    .state
                    .createCapsuleResponseModel
                    .copyWith(
                      openDate:
                          DateTime.now().millisecondsSinceEpoch.toString(),
                    ),
              ),
            );
            onPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment(1.00, 0.00),
                end: Alignment(-1, 0),
                colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text ?? context.tr('continue'),
                style: const TextStyle(
                  color: Color(0xFFE5E5E5),
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
