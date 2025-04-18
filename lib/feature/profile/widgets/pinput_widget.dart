import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinputWidget extends StatelessWidget {
  final Function(String) onCompleted;
  final String email;

  const PinputWidget({
    Key? key,
    required this.onCompleted,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Pinput(
        focusedPinTheme: PinTheme(
          textStyle: const TextStyle(
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.33,
          ),
          height: 75,
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: const Color(0xFF737A7F),
              ),
              borderRadius: BorderRadius.circular(12)),
        ),
        defaultPinTheme: PinTheme(
          textStyle: const TextStyle(
            color: Color(0xFF737A7F),
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.33,
          ),
          height: 75,
          decoration: BoxDecoration(
              color: const Color(0xFF282943),
              borderRadius: BorderRadius.circular(12)),
        ),
        errorText: 'Hatalı kod girdiniz, tekrar deneyiniz.',
        length: 4,
        onCompleted: onCompleted,
      ),
    );
  }
}
