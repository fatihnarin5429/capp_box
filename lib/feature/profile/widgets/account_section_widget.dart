import 'package:flutter/material.dart';
import 'package:capp_box/feature/package/widgets/profile_widgets.dart';
import 'package:capp_box/feature/profile/mixin/dialog_mixin.dart';

class AccountSectionWidget extends StatefulWidget {
  const AccountSectionWidget({super.key});

  @override
  State<AccountSectionWidget> createState() => _AccountSectionWidgetState();
}

class _AccountSectionWidgetState extends State<AccountSectionWidget>
    with DialogMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            'Hesap',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileListTile(
                leadingIcon: 'assets/images/logout.png',
                title: 'Çıkış Yap',
                subtitle: 'Çıkış Yap',
                onTap: () => showLogoutDialog(context),
              ),
              ProfileListTile(
                leadingIcon: 'assets/images/delete@2x.png',
                title: 'Hesabımı Sil',
                subtitle: 'Hesabımı Sil',
                onTap: () => showDeleteDialog(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
