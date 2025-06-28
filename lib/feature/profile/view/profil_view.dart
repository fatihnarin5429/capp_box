import 'package:capp_box/core/l10n/app_localizations.dart';

import 'package:capp_box/feature/package/widgets/profile_widgets.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';
import 'package:capp_box/feature/profile/view/eposta_view.dart';

import 'package:capp_box/feature/profile/view/name_view.dart';
import 'package:capp_box/feature/profile/view/password_view.dart';
import 'package:capp_box/feature/profile/view/phone_view.dart';

import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
    final localizations = AppLocalizations.of(context);

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
                        title: localizations.translate('full_name'),
                        subtitle:
                            state.displayName ??
                            localizations.translate('full_name'),
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NameView(),
                              ),
                            ),
                      ),
                      ProfileListTile(
                        leadingIcon: 'assets/icons/mail.png',
                        title: localizations.translate('email'),
                        subtitle: state.email ?? 'example@gmail.com',
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EpostaView(),
                              ),
                            ),
                      ),
                      ProfileListTile(
                        leadingIcon: 'assets/icons/password.png',
                        title: localizations.translate('password'),
                        subtitle: state.password ?? '**********',
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PasswordView(),
                              ),
                            ),
                      ),
                      ProfileListTile(
                        leadingIcon: 'assets/icons/mail.png',
                        title: localizations.translate('phone'),
                        subtitle: state.phone,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PhoneView(),
                              ),
                            ),
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
