import 'package:flutter/material.dart';

class CapsuleTitle extends StatelessWidget {
  const CapsuleTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
