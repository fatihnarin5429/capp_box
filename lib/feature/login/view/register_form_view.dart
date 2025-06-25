import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/feature/login/bloc/login_bloc.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
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
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildLabel(context, 'fullname'),
                ),
                CustomTextField(
                  textInputType: TextInputType.name,
                  controller: nameController,
                  hintText: context.tr('fullname_hint', args: {}),
                  style: const TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildLabel(context, 'email_input'),
                ),
                CustomTextField(
                  textInputType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: context.tr('email_input', args: {}),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildLabel(context, 'create_password'),
                ),
                CustomTextField(
                  textInputType: TextInputType.visiblePassword,
                  controller: passwordController,
                  hintText: context.tr('password_hint', args: {}),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: _buildLabel(context, 'password_confirm_label'),
                ),
                CustomTextField(
                  textInputType: TextInputType.visiblePassword,
                  controller: passwordConfirmController,
                  hintText: context.tr('password_confirm_hint', args: {}),
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

  Widget _buildLabel(BuildContext context, String key) {
    return Text(
      context.tr(key, args: {}),
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
            SnackBar(content: Text(context.tr('fill_all_fields', args: {}))),
          );
          return;
        }
        if (passwordController.text != passwordConfirmController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr('passwords_not_matching', args: {})),
            ),
          );
          return;
        }
        context.read<LoginBloc>().add(
          RegisterAction(
            phone: context.read<LoginBloc>().state.phone,
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
          MaterialPageRoute(builder: (context) => const HomeView2()),
        );
        onRegisterSuccess();
      },
      child: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            context.tr('register_button', args: {}),
            style: const TextStyle(
              color: Color(0xFFE5E5E5),
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
              height: 1.70,
            ),
          ),
        ),
      ),
    );
  }
}
