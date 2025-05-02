import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

mixin NotificationViewModel<T extends StatefulWidget> on State<T> {
  List<Map<String, String>> getNotifications(BuildContext context) {
    final now = DateTime.now();
    final futureDate = DateTime(now.year + 1, now.month, now.day);

    return List.generate(
      20,
      (index) => {
        "name": "Ted Mosby",
        "message": context.tr('notification_sent_capsule_message'),
        "date": context.formatDate(futureDate),
        "image": "https://placehold.co/40x40",
        "thumbnail": "assets/images/kilitkapsul.png",
      },
    );
  }
}
