import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/feature/login/mixin/login_mixin.dart';
import 'package:capp_box/feature/login/view/change_password_view.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView(
      {super.key,
      required TextEditingController emailController,
      required TextEditingController passwordController});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> with LoginMixin {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
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
          const SizedBox(height: 10),
          CustomTextField(
            controller: _emailController,
            labelText: 'E-posta',
            hintText: 'E-postanızı giriniz',
            autofocus: true,
            onChanged: (value) {},
          ),
          const SizedBox(height: 18),
          const Text(
            'Şifre ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
              height: 1.40,
            ),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: _passwordController,
            labelText: 'Şifre',
            hintText: 'Şifrenizi giriniz',
            isPassword: true,
            isError: isPasswordError,
            onPasswordVisibilityChanged: (isVisible) {
              setState(() {});
            },
            onChanged: (value) {
              if (isPasswordError) {
                setState(() {
                  isPasswordError = false;
                });
              }
            },
          ),
          if (isPasswordError)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Girdiğiniz şifre hatalıdır',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePasswordView(),
                  ),
                );
              },
              child: const Text(
                'Şifremi Unuttum',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.08,
            child: ElevatedButton(
              onPressed: () {
                checkPassword(_passwordController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView2(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ).copyWith(
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  return null;
                }),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(1.00, 0.00),
                    end: Alignment(-1, 0),
                    colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Giriş Yap',
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
