import 'package:flutter/material.dart';
import 'package:capp_box/feature/profile/view/email_otp_view.dart';

Widget buildEditButton(
    BuildContext context, TextEditingController emailController,
    {required Null Function() onPressed}) {
  return SizedBox(
    width: double.infinity,
    height: 60,
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmailOtpView(email: emailController.text),
          ),
        );
      },
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
        child: const Center(
          child: Text(
            'Düzenle',
            style: TextStyle(
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
