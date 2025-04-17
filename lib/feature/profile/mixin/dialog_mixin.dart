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
      title: 'Hesabınızı silmek istediğinizden emin misiniz?',
      description: 'Bu işlem geri alınamaz.',
      confirmButtonText: 'Hesabımı Sil',
      cancelButtonText: 'İptal Et',
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
      title: 'Çıkış yapmak istediğinizden emin misiniz?',
      description: 'Hesabınızdan çıkış yapılacaktır.',
      confirmButtonText: 'Çıkış Yap',
      cancelButtonText: 'İptal Et',
      onConfirm: () {
        context.read<ProfileBloc>().add(
              ProfileLogout(email: '', password: ''),
            );
        Navigator.pop(context);
      },
    );
  }
}
