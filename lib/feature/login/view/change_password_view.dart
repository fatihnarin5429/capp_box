import 'package:capp_box/feature/login/view/change_password_2_view.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';

import 'package:capp_box/product/widgets/login_background_gradient.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField(
        textInputType: TextInputType.emailAddress,
        controller: _emailController,
        hintText: 'E-posta',
        isPassword: false,
        onChanged: (String value) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.backgroundDark1,
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Şifre Yenileme',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Lütfen e-postanızı girin, bir sonraki adımda şifrenizi sıfırlamak için bir OTP kodu göndereceğiz.',
                          style: TextStyle(
                            color: Color(0xFF84858E),
                            fontSize: 14,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'E-posta',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePassword2(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: const Center(
                                  child: Text(
                                'Devam Et',
                                style: TextStyle(
                                  color: Color(0xFFE5E5E5),
                                  fontSize: 14,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
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
          ),
        ],
      ),
    );
  }
}
