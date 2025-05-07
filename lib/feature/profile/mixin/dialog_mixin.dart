import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/package/widgets/custom_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';

mixin DialogMixin<T extends StatefulWidget> on State<T> {
  void showCustomDialog({
    required BuildContext context,
    required String imagePath,
    required String title,
    required String description,
    required String confirmButtonText,
    required String cancelButtonText,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          imagePath: imagePath,
          imageWidth: 219.48,
          imageHeight: 170.49,
          title: title,
          description: description,
          confirmButtonText: confirmButtonText,
          cancelButtonText: cancelButtonText,
          onConfirm: onConfirm,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      imagePath: 'assets/images/sil.png',
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
    );
  }

  void showLogoutDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      imagePath: 'assets/images/cikis.png',
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
    );
  }
}
