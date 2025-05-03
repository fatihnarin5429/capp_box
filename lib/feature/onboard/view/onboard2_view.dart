import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:flutter/material.dart';
import '../mixin/onboard2_mixin.dart';

class Onboard2View extends StatefulWidget {
  const Onboard2View({super.key});

  @override
  State<Onboard2View> createState() => _Onboard2ViewState();
}

class _Onboard2ViewState extends State<Onboard2View> with Onboard2Mixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConst.backgroundColor,
              ColorConst.backgroundColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          // Kaydırılabilir ekran
          physics:
              const BouncingScrollPhysics(), // iOS ve Android için güzel kaydırma efekti
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height, // Taşmayı önler
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20), // Kenarlardan padding ekledik
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logocappbox.png',
                      width: 200,
                      height: 200,
                    ),

                    isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: 322,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: context
                                        .tr('remember_your_memories', args: {}),
                                    style: _textStyle(20),
                                  ),
                                  TextSpan(
                                    text:
                                        context.tr('carry_to_future', args: {}),
                                    style: _textStyle(32),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                    // Butonlar için boşluk
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: buildAuthButtons(),
                    ),
                    // En altta biraz boşluk bırak
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle(double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700,
      letterSpacing: -0.32,
      height: 1.25,
    );
  }
}
