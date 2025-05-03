import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class SMSNotificationOptions extends StatelessWidget {
  final bool sendSMS;
  final Function(bool) onSendSMSChanged;

  const SMSNotificationOptions({
    Key? key,
    required this.sendSMS,
    required this.onSendSMSChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('sms_notification_message'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
            height: 1.40,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            GestureDetector(
              onTap: () => onSendSMSChanged(true),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: sendSMS
                      ? const LinearGradient(
                          colors: [
                            Color(0xFFE0AEEC),
                            Color(0xFF445BD1),
                          ],
                        )
                      : null,
                  border: sendSMS
                      ? null
                      : Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                ),
                child: sendSMS
                    ? const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              context.tr('yes'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
                height: 1.40,
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            GestureDetector(
              onTap: () => onSendSMSChanged(false),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: !sendSMS
                      ? const LinearGradient(
                          colors: [
                            Color(0xFFE0AEEC),
                            Color(0xFF445BD1),
                          ],
                        )
                      : null,
                  border: !sendSMS
                      ? null
                      : Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                ),
                child: !sendSMS
                    ? const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              context.tr('no'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
                height: 1.40,
              ),
            )
          ],
        ),
      ],
    );
  }
}
