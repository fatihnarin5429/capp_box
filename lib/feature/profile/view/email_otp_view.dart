import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:capp_box/feature/package/widgets/success_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/profile/widgets/pinput_widget.dart';

class EmailOtpView extends StatefulWidget {
  final String email;
  const EmailOtpView({
    super.key,
    required this.email,
    required bool isEmail,
    required String name,
    required String otp,
    required String phone,
  });

  @override
  State<EmailOtpView> createState() => _EmailOtpViewState();
}

class _EmailOtpViewState extends State<EmailOtpView> {
  List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
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
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _remainingTime = 59; // Reset timer when starting
    });

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return; // Check if widget is mounted

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
    SuccessDialog.show(
      context: context,
      message: context.tr('email_verified', args: {}),
      onComplete: () {
        if (!mounted) return;
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/profil_view', (route) => false);
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                      Expanded(
                        child: Text(
                          context.tr('email_verification_title', args: {}),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                    context.tr(
                      'email_verification_message',
                      args: {'email': widget.email},
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  PinputWidget(
                    controller: controllers[0],
                    focusNode: focusNodes[0],
                    email: widget.email,
                    onCompleted: (pin) {
                      context.read<ProfileBloc>().add(
                        ProfileChangeEmail(email: widget.email),
                      );
                      verifyOtp();
                    },
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
            ? context.tr('resend_code', args: {})
            : context.tr('resend_code_message', args: {'time': _remainingTime}),
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
