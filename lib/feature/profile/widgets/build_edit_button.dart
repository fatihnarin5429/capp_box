import 'package:flutter/material.dart';

Widget buildEditButton(
  BuildContext context, {
  required VoidCallback onPressed,
  String buttonText = 'Düzenle',
}) {
  return SizedBox(
    width: double.infinity,
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
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, 0.00),
            end: Alignment(-1, 0),
            colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Color(0xFFE5E5E5),
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    ),
  );
}
