import 'package:flutter/material.dart';

mixin NotificationViewModel {
  List<Map<String, String>> getNotifications() {
    return List.generate(
      20,
      (index) => {
        "name": "Ted Mosby",
        "message": "sana bir video kapsül gönderdi!",
        "date": "11/02/2025",
        "image": "https://placehold.co/40x40",
        "thumbnail": "assets/images/kilitkapsul.png",
      },
    );
  }
}
