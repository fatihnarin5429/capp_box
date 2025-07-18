import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/widgets/continue_button.dart';
import 'package:capp_box/feature/login/view/new_passxord_view.dart';
import 'package:capp_box/feature/profile/widgets/pinput_widget.dart';

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
        SnackBar(content: Text(context.tr('enter_4_digit_code', args: {}))),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    context.tr('password_reset', args: {}),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.tr('otp_code_sent', args: {'email': _maskedEmail}),
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
                  _buildResendCodeSection(context),
                  const Spacer(),
                  ContinueButton(
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

Widget _buildResendCodeSection(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        context.tr('did_not_receive_code', args: {}),
        style: const TextStyle(
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
        child: Text(
          context.tr('resend', args: {}),
          style: const TextStyle(
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
