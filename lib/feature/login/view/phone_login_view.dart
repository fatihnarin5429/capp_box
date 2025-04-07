import 'package:capp_box/feature/login/view/phone_login_otp_view.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';

class PhoneLoginView extends StatefulWidget {
  const PhoneLoginView({super.key});

  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Geri butonu
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
                          'Kayıt Ol',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF1F1F1),
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                            letterSpacing: -0.50,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  // Başlık
                  const Text(
                    'Hoşgeldiniz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Alt başlık
                  const Text(
                    'Devam etmek için telefon numaranızı girin.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Telefon numarası girişi
                  CustomTextField(
                    controller: _phoneController,
                    hintText: 'Telefon Numaranız',
                    onChanged: (value) {
                      // Telefon numarası değiştiğinde yapılacak işlemler
                    },
                    keyboardType: TextInputType.phone,
                  ),

                  const Spacer(),
                  // Kayıt ol butonu
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
                                builder: (context) => PhoneLoginOtpView(
                                  phoneNumber: _phoneController.text,
                                ),
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
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
