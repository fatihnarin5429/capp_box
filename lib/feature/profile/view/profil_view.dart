import 'package:capp_box/feature/package/widgets/custom_navigation_bar.dart';
import 'package:capp_box/feature/package/widgets/profile_widgets.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';
import 'package:capp_box/feature/profile/view/eposta_view.dart';
import 'package:capp_box/feature/profile/view/gizlilik_view.dart';
import 'package:capp_box/feature/profile/view/help_View.dart';
import 'package:capp_box/feature/profile/view/name_view.dart';
import 'package:capp_box/feature/profile/view/password_view.dart';
import 'package:capp_box/feature/profile/view/phone_view.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:capp_box/core/services/image_picker_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/package/widgets/custom_dialog.dart';
import 'package:capp_box/feature/profile/mixin/deleted_mixin.dart';
import 'package:capp_box/feature/profile/mixin/image_picker_mixin.dart';
import 'package:capp_box/feature/profile/mixin/dialog_mixin.dart';
import 'package:capp_box/feature/profile/widgets/profile_header_widget.dart';
import 'package:capp_box/feature/profile/widgets/privacy_section_widget.dart';
import 'package:capp_box/feature/profile/widgets/account_section_widget.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView>
    with ProfileMixin, ImagePickerMixin, DialogMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              const BackgroundGradient(),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileHeaderWidget(onImageTap: pickImage),
                      ProfileListTile(
                        leadingIcon: 'assets/icons/profile3.png',
                        title: 'İsim Soyisim',
                        subtitle: state.displayName ?? 'İsim Soyisim',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NameView())),
                      ),
                      ProfileListTile(
                        leadingIcon: 'assets/icons/mail.png',
                        title: 'E-posta',
                        subtitle: state.email ?? 'example@gmail.com',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EpostaView())),
                      ),
                      ProfileListTile(
                        leadingIcon: 'assets/icons/password.png',
                        title: 'Şifre',
                        subtitle: state.password ?? '**********',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PasswordView())),
                      ),
                      ProfileListTile(
                        leadingIcon: 'assets/icons/mail.png',
                        title: 'Telefon',
                        subtitle: state.phone ?? '+90 555 123 45 67',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PhoneView())),
                      ),
                      const PrivacySectionWidget(),
                      const AccountSectionWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          extendBody: true,
        );
      },
    );
  }
}
