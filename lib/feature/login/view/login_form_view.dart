import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/feature/login/bloc/login_bloc.dart';
import 'package:capp_box/feature/login/mixin/login_mixin.dart';
import 'package:capp_box/feature/login/view/change_password_view.dart';
import 'package:capp_box/feature/login/widgets/google_sign_in_button.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/product/utility/enums/status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  });

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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == StatusEnum.success && state.isAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeView2()),
          );
        }
        if (state.status == StatusEnum.error && state.authError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.authError!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                context.tr('email_input', args: {}),
                style: const TextStyle(
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
                labelText: context.tr('email_input', args: {}),
                hintText: context.tr('email_hint', args: {}),
                autofocus: true,
                textInputType: TextInputType.emailAddress,
                onChanged: (value) {},
              ),
              const SizedBox(height: 18),
              Text(
                context.tr('password', args: {}),
                style: const TextStyle(
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
                labelText: context.tr('password', args: {}),
                hintText: context.tr('password_hint', args: {}),
                isPassword: true,
                isError: isPasswordError,
                textInputType: TextInputType.visiblePassword,
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
                    context.tr('invalid_credentials', args: {}),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              const SizedBox(height: 18),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordView(),
                    ),
                  );
                },
                child: Text(
                  context.tr('forgot_password_short', args: {}),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Apple Sign-In Butonu
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      context.read<LoginBloc>().add(AppleSignInAction());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.apple,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Apple ile Giriş Yap',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              // Google Sign-In Butonu
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      context.read<LoginBloc>().add(GoogleSignInAction());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/google.svg',
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Google ile Giriş Yap',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 14,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Email/Password ile Giriş Butonu
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        context.read<LoginBloc>().add(
                          EmailPasswordLoginAction(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Lütfen email ve şifre alanlarını doldurun',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child:
                              state.status == StatusEnum.loading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    context.tr('login_button', args: {}),
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
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
