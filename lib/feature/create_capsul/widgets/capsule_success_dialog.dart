import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/view/capsule_buy_view.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/package/payment_view.dart';

class CapsuleSuccessDialog extends StatelessWidget {
  const CapsuleSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 358,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: const Color(0xFF10101C),
          borderRadius: BorderRadius.circular(32),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/image.png',
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red, size: 50);
                },
              ),
              const SizedBox(height: 16),
              Text(
                context.tr('success_message'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.tr('payment_message'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
                strokeWidth: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void show(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CapsuleBuyView(),
            ),
            (route) => false,
          );
        });

        return const CapsuleSuccessDialog();
      },
    );
  }
}
