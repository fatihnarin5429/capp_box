import 'package:capp_box/feature/create_capsul/view/capsule_buy_view.dart';
import 'package:capp_box/feature/onboard/mixin/onboard1_mixin.dart';
import 'package:capp_box/feature/onboard/view/onboard2_view.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:capp_box/feature/login/view/login_view.dart';

class Onboard1View extends StatefulWidget {
  const Onboard1View({super.key});

  @override
  State<Onboard1View> createState() => _Onboard1ViewState();
}

class _Onboard1ViewState extends State<Onboard1View> with Onboard1Mixin {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1C1D31),
              Color(0xFF1C1D31),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GifView.asset(
                  'assets/images/rocket.gif',
                  height: 150,
                  width: 150,
                  frameRate: 30,
                ),
                const SizedBox(height: 40),
                Center(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const SizedBox(
                          width: 322,
                          child: Text(
                            'Cappbox ile sevdiklerinize özel zaman kapsülleri oluşturun ve unutulmaz bağlar kurun.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 92),
                const SizedBox(
                    width: 328,
                    child: Text(
                      'Devam ederek Kullanım Koşullarımızı kabul etmiş olursunuz. Göz at: Gizlilik Sözleşmesi & Kullanım Koşulları',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                const SizedBox(height: 8),
                Container(
                  width: 327,
                  height: 56,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(1.00, 0.00),
                      end: Alignment(-1, 0),
                      colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Onboard2View(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Şimdi Başla',
                          style: TextStyle(
                            color: Color(0xFFE5E5E5),
                            fontSize: 14,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                    );
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    child: const Text(
                      'Cappbox hesabın var mı? Giriş Yap',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        height: 1.70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
