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
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }
}
