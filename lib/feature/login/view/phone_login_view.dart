import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';

import 'package:capp_box/feature/home/widgets/capsule_title.dart';
import 'package:capp_box/feature/login/bloc/login_bloc.dart';

import 'package:capp_box/feature/login/view/phone_login_otp_view.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';

class PhoneLoginView extends StatefulWidget {
  const PhoneLoginView({super.key});

  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(
      text: context.read<LoginBloc>().state.phone,
    );
  }

  @override
  void didUpdateWidget(PhoneLoginView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _phoneController.text = context.read<LoginBloc>().state.phone;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        _phoneController.text = state.phone ?? "5XX XXX XX XX";

        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: [
                const BackgroundGradient(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const BackButtonWidget(),
                            Expanded(
                              child: Center(
                                child: CapsuleTitle(
                                  title: context.tr('register'),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Text(
                            context.tr('welcome'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            context.tr("Enter your phone number to continue"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: CustomTextField(
                            keyboardType: TextInputType.phone,
                            textInputType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            autofocus: state.phone.isEmpty,
                            controller: _phoneController,
                            hintText: "0XXX XXX XX XX",
                            onChanged: (value) {
                              if (value.isEmpty || value[0] == '0') {
                                context.read<LoginBloc>().add(
                                  LoginChangePhone(phone: value),
                                );
                                return;
                              }

                              String formattedPhone = '0$value';
                              if (formattedPhone.length > 10) {
                                formattedPhone = formattedPhone.substring(
                                  0,
                                  10,
                                );
                              }
                              if (formattedPhone.length < 10) {
                                formattedPhone = formattedPhone.padRight(
                                  10,
                                  '0',
                                );
                              }

                              _phoneController.value = TextEditingValue(
                                text: formattedPhone,
                                selection: TextSelection.collapsed(
                                  offset: formattedPhone.length,
                                ),
                              );

                              context.read<LoginBloc>().add(
                                LoginChangePhone(phone: formattedPhone),
                              );
                            },
                          ),
                        ),
                        const Spacer(),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: SizedBox(
                                width: 350,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => PhoneLoginOtpView(
                                              phoneNumber: state.phone,
                                            ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment(1.00, 0.00),
                                        end: Alignment(-1, 0),
                                        colors: [
                                          Color(0xFFB224EF),
                                          Color(0xFF7579FF),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        context.tr('continue'),
                                        style: const TextStyle(
                                          color: Color(0xFFE5E5E5),
                                          fontSize: 16,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
