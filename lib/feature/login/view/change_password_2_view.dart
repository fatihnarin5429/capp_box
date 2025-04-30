import 'package:capp_box/feature/login/view/new_passxord_view.dart';
import 'package:capp_box/feature/profile/widgets/pinput_widget.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:flutter/material.dart';

class ChangePassword2 extends StatefulWidget {
  const ChangePassword2({super.key});

  @override
  State<ChangePassword2> createState() => _ChangePassword2State();
}

class _ChangePassword2State extends State<ChangePassword2> {
  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Widget _buildOTPBox(int index) {
    return PinputWidget(
      email: '',
      onCompleted: (pin) {
        // Handle pin completion
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 120),
            const Text(
              'erv****@gmail.com e-postanıza bir OTP kodu gönderdik. Aşağıdaki kodu girin.',
              style: TextStyle(
                color: Color(0xFF84858E),
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _buildOTPBox(index)),
            ),
            const Spacer(),
            Center(
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(1.00, 0.00),
                    end: Alignment(-1, 0),
                    colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPasswordView(),
                        ),
                      );
                      // Telefon doğrulama işlemleri buraya gelecek
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      'Devam Et',
                      style: TextStyle(
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
    );
  }
}
