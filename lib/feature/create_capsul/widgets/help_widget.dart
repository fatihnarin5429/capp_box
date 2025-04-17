import 'package:flutter/material.dart';

class HelpWidget extends StatelessWidget {
  final String text;
  final Widget? trailingIcon;
  final VoidCallback? onTap;

  const HelpWidget({
    super.key,
    required this.text,
    this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Urbanist',
                ),
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 12),
              trailingIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
