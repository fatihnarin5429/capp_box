import 'package:flutter/material.dart';

class CapsuleTitle extends StatelessWidget {
  const CapsuleTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Kapsüller',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
