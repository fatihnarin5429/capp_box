import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/login/mixin/build_password_field.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView>
    with PasswordFieldMixin {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    context.tr('new_password', args: {}),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  buildPasswordField(context.tr('enter_password', args: {})),
                  const SizedBox(height: 35),
                  Text(
                    context.tr('new_password_confirm', args: {}),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  buildPasswordField(
                      context.tr('enter_password_again', args: {})),
                  const SizedBox(height: 8),
                  const Expanded(child: SizedBox()),
                  Center(
                    child: Container(
                      width: 327,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(1.00, 0.00),
                          end: Alignment(-1, 0),
                          colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                insetPadding: EdgeInsets.zero,
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10101C),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          'assets/images/image.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      Text(
                                        context.tr('password_reset_successful',
                                            args: {}),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        context.tr('redirecting_to_home',
                                            args: {}),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(
                                          color: Color(0xFFB224EF),
                                          strokeWidth: 3,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            context.tr('continue_button', args: {}),
                            style: const TextStyle(
                              color: Color(0xFFE5E5E5),
                              fontSize: 14,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
