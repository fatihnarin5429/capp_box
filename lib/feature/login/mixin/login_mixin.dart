import 'package:flutter/material.dart';

mixin LoginMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  late TabController tabController;
  bool isPasswordError = false;

  void checkPassword(String password) {
    // Örnek bir şifre kontrolü - gerçek uygulamada bu API'den gelecektir
    const String correctPassword = "123456"; // Test için örnek şifre

    setState(() {
      isPasswordError = password != correctPassword;
    });
  }
}
