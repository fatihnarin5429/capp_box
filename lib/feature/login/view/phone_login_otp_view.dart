import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/home/widgets/capsule_title.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BackButtonWidget(),
                      Expanded(
                        child: Center(
                          child: CapsuleTitle(
                            title: 'Kayıt Ol',
                          ),
                        ),
                      ),
                      SizedBox(width: 40), // To balance the back button
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      '${widget.phoneNumber} nolu telefon numaranıza OTP kodu gönderdik \nLütfen kodu giriniz.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Pinput(
                        autofocus: true,
                        focusedPinTheme: PinTheme(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                          height: 75,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        defaultPinTheme: PinTheme(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, right: 0),
                    child: _buildResendButton(),
                  ),
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
          color: _remainingTime <= 0 ? Colors.red : Colors.white,
          fontSize: 12,
          decoration: TextDecoration.underline,
          decorationColor: _remainingTime <= 0 ? Colors.red : Colors.white,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
