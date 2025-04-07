import 'package:flutter/material.dart';

class TimeComponent extends StatelessWidget {
  final String value;
  final String label;

  const TimeComponent({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF80B0C4),
            fontSize: 12.33,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF80B0C4),
            fontSize: 4.24,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
