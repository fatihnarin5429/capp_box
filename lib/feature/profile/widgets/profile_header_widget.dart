import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';
import 'dart:io';

class ProfileHeaderWidget extends StatelessWidget {
  final VoidCallback onImageTap;

  const ProfileHeaderWidget({
    super.key,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: onImageTap,
                child: Container(
                  width: 83,
                  height: 83,
                  decoration: ShapeDecoration(
                    color: Colors.grey[300],
                    shape: const OvalBorder(),
                  ),
                  child: state.imagePath != null
                      ? ClipOval(
                          child: Image.file(
                            File(state.imagePath!),
                            width: 83,
                            height: 83,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                          size: 30,
                        ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onImageTap,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  context.tr('change_photo'),
                  style: const TextStyle(
                    color: Color(0xFFE2A380),
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
