import 'package:capp_box/feature/package/widgets/custom_navigation_bar.dart';
import 'package:capp_box/feature/package/widgets/profile_widgets.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';
import 'package:capp_box/feature/profile/view/eposta_view.dart';
import 'package:capp_box/feature/profile/view/name_view.dart';
import 'package:capp_box/feature/profile/view/password_view.dart';
import 'package:capp_box/feature/profile/view/phone_view.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:capp_box/core/services/image_picker_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  final ImagePickerService _imagePickerService = ImagePickerService();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final File? image = await _imagePickerService.pickImageFromGallery();
    if (image != null) {
      // Onay dialog'unu göster
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorConst.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Fotoğrafı Onayla',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Seçtiğiniz fotoğrafı profil fotoğrafı olarak kullanmak istiyor musunuz?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                const BackgroundGradient(),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Profil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: _pickImage,
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
                        ],
                      ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Fotoğrafı Değiştir',
                            style: TextStyle(
                              color: Color(0xFFE2A380),
                              fontSize: 14,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              height: 1.44,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ProfileListTile(
                                leadingIcon: 'assets/icons/profile3.png',
                                title: 'İsim Soyisim',
                                subtitle: state.displayName ?? 'İsim Soyisim',
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NameView()));
                                },
                              ),
                              ProfileListTile(
                                leadingIcon: 'assets/icons/mail.png',
                                title: 'E-posta',
                                subtitle: state.email ?? 'example@gmail.com',
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EpostaView()));
                                },
                              ),
                              ProfileListTile(
                                leadingIcon: 'assets/icons/password.png',
                                title: 'Şifre',
                                subtitle: state.password ?? '**********',
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PasswordView()));
                                },
                              ),
                              ProfileListTile(
                                leadingIcon: 'assets/icons/mail.png',
                                title: 'Telefon',
                                subtitle: state.phone ?? '+90 555 123 45 67',
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PhoneView()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          extendBody: true,
        );
      },
    );
  }
}
