import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  const ContinueButton({
    Key? key,
    required this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: SizedBox(
        width: 350,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment(1.00, 0.00),
                end: Alignment(-1, 0),
                colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text ?? context.tr('continue'),
                style: const TextStyle(
                  color: Color(0xFFE5E5E5),
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
