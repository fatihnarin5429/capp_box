import 'package:capp_box/product/constants/color_cons.dart';
import 'package:flutter/material.dart';

class LoginBackgroundGradient extends StatefulWidget {
  const LoginBackgroundGradient({super.key});

  @override
  State<LoginBackgroundGradient> createState() =>
      _LoginBackgroundGradientState();
}

class _LoginBackgroundGradientState extends State<LoginBackgroundGradient> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.centerLeft,
          colors: [ColorConst.backgroundDark1, ColorConst.backgroundDark1],
        ),
      ),
    );
  }
}
