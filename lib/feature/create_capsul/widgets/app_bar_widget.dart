import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 24,
        ),
        onPressed: () {
          Navigator.maybePop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        context.tr('payment_title'),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          fontFamily: 'Urbanist',
        ),
      ),
    );
  }
}
