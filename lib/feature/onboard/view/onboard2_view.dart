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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorConst.backgroundColor, ColorConst.backgroundColor],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height,
                maxWidth: 400,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/images/logocappbox.png',
                      width: 180,
                      height: 180,
                    ),
                    const SizedBox(height: 30),

                    // Yüklenme animasyonu veya metin
                    isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : SizedBox(
                          width: 322,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: context.tr(
                                    'remember_your_memories',
                                    args: {},
                                  ),
                                  style: _textStyle(20),
                                ),
                                TextSpan(
                                  text: context.tr('carry_to_future', args: {}),
                                  style: _textStyle(32),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                    const SizedBox(height: 40),

                    // Giriş butonları (Apple, Google, Email, Phone)
                    buildAuthButtons(),
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

  @override
  void _showErr(String msg) {
    // Burada mixin'deki metodu override edip snackbar ile gösterebiliriz
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
