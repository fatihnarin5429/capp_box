import 'package:capp_box/feature/home/view/home_view.dart';
import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/feature/login/bloc/login_bloc.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterFormView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final VoidCallback onRegisterSuccess;
  final TextEditingController nameController;
  const RegisterFormView({
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
    required this.onRegisterSuccess,
    required this.nameController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildLabel('Ad - Soyad'),
                ),
                CustomTextField(
                  controller: nameController,
                  hintText: 'Adınız-Soyadınız',
                  keyboardType: TextInputType.name,
                  style: const TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildLabel('E-posta'),
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: 'E-posta',
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildLabel('Şifre Oluştur'),
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Şifre',
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildLabel('Şifre Tekrar'),
                ),
                CustomTextField(
                  controller: passwordConfirmController,
                  hintText: 'Şifre Tekrar',
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: _buildRegisterButton(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500,
        height: 1.40,
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (emailController.text.isEmpty ||
            passwordController.text.isEmpty ||
            passwordConfirmController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lütfen tüm alanları doldurun')),
          );
          return;
        }
        if (passwordController.text != passwordConfirmController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Şifreler eşleşmiyor')),
          );
          return;
        }
        context.read<LoginBloc>().add(
              RegisterAction(
                user: context.read<LoginBloc>().state.user!.copyWith(
                      password: passwordController.text,
                      email: emailController.text,
                      name: nameController.text,
                      createdAt: DateTime.now(),
                      isEmailVerified: false,
                    ),
              ),
            );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView2(),
          ),
        );
        onRegisterSuccess();
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, 0.00),
            end: Alignment(-1, 0),
            colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Kayıt Ol',
          style: TextStyle(
            color: Color(0xFFE5E5E5),
            fontSize: 14,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
