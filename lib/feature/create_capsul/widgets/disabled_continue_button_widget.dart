import 'package:flutter/material.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/product/constants/color_cons.dart';

class DisabledContinueButtonWidget extends StatelessWidget {
  const DisabledContinueButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          colors: [ColorConst.topLeftPurple1, ColorConst.topLeftPurple2],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        context.tr('continue') ?? 'Devam Et',
        style: const TextStyle(
          color: Color(0xFFE5E5E5),
          fontSize: 16,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
