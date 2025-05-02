import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Row(
        children: [
          const Spacer(),
          Text(
            context.tr('notifications'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Urbanist',
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
