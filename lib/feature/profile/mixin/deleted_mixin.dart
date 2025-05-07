import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';
import 'package:capp_box/feature/package/widgets/custom_dialog.dart';

mixin ProfileMixin {
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          imagePath: 'assets/images/sil.png',
          imageWidth: 219.48,
          imageHeight: 170.49,
          title: context.tr('delete_account', args: {}),
          description: context.tr('delete_account_description', args: {}),
          confirmButtonText: context.tr('delete_account_button', args: {}),
          cancelButtonText: context.tr('cancel_button', args: {}),
          onConfirm: () {
            context.read<ProfileBloc>().add(
                  ProfileDelete(password: '', email: ''),
                );
            Navigator.pop(context);
          },
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          imagePath: 'assets/images/cikis.png',
          imageWidth: 219.48,
          imageHeight: 170.49,
          title: context.tr('logout_confirmation', args: {}),
          description: context.tr('logout_confirmation_description', args: {}),
          confirmButtonText: context.tr('logout_button', args: {}),
          cancelButtonText: context.tr('cancel_button', args: {}),
          onConfirm: () {
            context.read<ProfileBloc>().add(
                  ProfileLogout(email: '', password: ''),
                );
            Navigator.pop(context);
          },
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }
}
