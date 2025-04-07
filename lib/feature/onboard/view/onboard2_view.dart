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
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height, // Taşmayı önler
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 20), // Kenarlardan padding ekledik
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/logocappbox.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20), // Görsel ile yazı arasında boşluk
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: 322,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Anılarınızı geleceğe\n',
                                style: _textStyle(20),
                              ),
                              TextSpan(
                                text: 'taşıyın',
                                style: _textStyle(32),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                const SizedBox(height: 40), // Butonlar için boşluk
                buildAuthButtons(),
                const SizedBox(height: 40), // En altta biraz boşluk bırak
              ],
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
