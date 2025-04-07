import 'package:capp_box/feature/package/widgets/custom_navigation_bar.dart';
import 'package:capp_box/feature/notifaction/mixins/notification_view_model.dart';
import 'package:capp_box/feature/notifaction/widgets/notification_header.dart';
import 'package:capp_box/feature/notifaction/widgets/notification_item.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with NotificationViewModel {
  late final List<Map<String, String>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: notifications.length + 1,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const NotificationHeader();
                      }
                      final notification = notifications[index - 1];
                      return NotificationItem(
                        name: notification["name"]!,
                        message: notification["message"]!,
                        date: notification["date"]!,
                        image: notification["image"]!,
                        thumbnail: notification["thumbnail"]!,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      extendBody: true,
    );
  }
}
