import 'package:capp_box/feature/package/widgets/success_dialog.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pinput/pinput.dart';

class PhoneLoginOtpView extends StatefulWidget {
  final String phoneNumber;
  const PhoneLoginOtpView({super.key, required this.phoneNumber});

  @override
  State<PhoneLoginOtpView> createState() => _PhoneLoginOtpViewState();
}

class _PhoneLoginOtpViewState extends State<PhoneLoginOtpView> {
  Timer? _timer;
  int _remainingTime = 59;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _remainingTime = 59;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        if (_remainingTime <= 0) {
          timer.cancel();
        } else {
          _remainingTime--;
        }
      });
    });
  }

  void verifyOtp() {
    _timer?.cancel();
    if (!mounted) return;

    // Show success dialog and navigate to home
    SuccessDialog.show(
      context: context,
      message: 'Giriş başarılı.',
      onComplete: () {
        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/ellipse.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Giriş',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Telefon numaranıza OTP kodu gönderdik\n${widget.phoneNumber}\nLütfen kodu giriniz.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Pinput(
                      focusedPinTheme: PinTheme(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 1.33,
                        ),
                        height: 75,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: const Color(0xFF737A7F),
                            ),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      defaultPinTheme: PinTheme(
                        textStyle: const TextStyle(
                          color: Color(0xFF737A7F),
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 1.33,
                        ),
                        height: 75,
                        decoration: BoxDecoration(
                            color: const Color(0xFF282943),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      errorText: 'Hatalı kod girdiniz, tekrar deneyiniz.',
                      length: 4,
                      onCompleted: (pin) => verifyOtp(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildResendButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResendButton() {
    return TextButton(
      onPressed: _remainingTime <= 0 ? startTimer : null,
      child: Text(
        _remainingTime <= 0
            ? 'Kodu Tekrar Gönder'
            : 'Kodu $_remainingTime saniye sonra tekrar gönderebilirsiniz',
        style: TextStyle(
          color: _remainingTime <= 0 ? Colors.blue : Colors.white,
          fontSize: 14,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
