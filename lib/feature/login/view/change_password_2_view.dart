import 'package:capp_box/feature/create_capsul/widgets/continue_button.dart';
import 'package:capp_box/feature/login/view/new_passxord_view.dart';
import 'package:capp_box/feature/profile/widgets/pinput_widget.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

class ChangePassword2 extends StatefulWidget {
  const ChangePassword2({super.key});

  @override
  State<ChangePassword2> createState() => _ChangePassword2State();
}

class _ChangePassword2State extends State<ChangePassword2> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final String _maskedEmail = 'erv****@gmail.com';

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _verifyOtpAndProceed() {
    final enteredOtp = _pinController.text.trim();
    if (enteredOtp.length == 4) {
      // Gerçek doğrulama burada yapılmalı
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NewPasswordView()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen 4 haneli kodu girin')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Şifre Sıfırlama',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$_maskedEmail e-postanıza bir OTP kodu gönderdik. Aşağıdaki kodu girin.',
                    style: const TextStyle(
                      color: Color(0xFF84858E),
                      fontSize: 14,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 32),
                  PinputWidget(
                    email: _maskedEmail,
                    onCompleted: (_) => _verifyOtpAndProceed(),
                    controller: _pinController,
                    focusNode: _focusNode,
                  ),
                  const SizedBox(height: 24),
                  _buildResendCodeSection(),
                  const Spacer(),
                  ContinueButton(
                    displayNameController: _pinController,
                    mailController: TextEditingController(),
                    phoneController: TextEditingController(),
                    secilenTip: MediaType.mail,
                    onPressed: _verifyOtpAndProceed,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildResendCodeSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'Kod almadınız mı? ',
        style: TextStyle(
          color: Color(0xFF84858E),
          fontSize: 14,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w400,
        ),
      ),
      TextButton(
        onPressed: () {
          // OTP yeniden gönderme işlemi yapılmalı
        },
        child: const Text(
          'Yeniden Gönder',
          style: TextStyle(
            color: Color(0xFFB224EF),
            fontSize: 14,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}
