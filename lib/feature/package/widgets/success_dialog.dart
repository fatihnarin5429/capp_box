import 'package:flutter/material.dart';

class SuccessDialog {
  static void show({
    required BuildContext context,
    required String message,
    String imagePath = 'assets/images/image.png',
    VoidCallback? onComplete,
    Duration duration = const Duration(seconds: 2),
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        Future.delayed(duration, () {
          if (dialogContext.mounted) {
            Navigator.pop(dialogContext);
            onComplete?.call();
          }
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 358,
            constraints: const BoxConstraints(minHeight: 326),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF10101C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 310,
                  height: 104,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        imagePath,
                        width: 104,
                        height: 104,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          print('Image error: $error');
                          return const Icon(Icons.error,
                              size: 104, color: Colors.white);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
