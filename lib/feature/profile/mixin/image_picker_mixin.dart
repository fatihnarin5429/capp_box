import 'dart:io';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/core/services/image_picker_service.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';
import 'package:capp_box/product/constants/color_cons.dart';

mixin ImagePickerMixin<T extends StatefulWidget> on State<T> {
  final ImagePickerService _imagePickerService = ImagePickerService();
  File? _selectedImage;

  Future<void> pickImage() async {
    final File? image = await _imagePickerService.pickImageFromGallery();
    if (image != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorConst.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              context.tr('confirm_photo'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.tr('confirm_photo_message'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Vazgeç',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _selectedImage = image);
                      context
                          .read<ProfileBloc>()
                          .add(ProfileChangeImage(imagePath: image.path));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Onayla',
                      style: TextStyle(
                        color: Color(0xFFE2A380),
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
  }
}
