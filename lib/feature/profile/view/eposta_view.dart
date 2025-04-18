import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';
import 'package:capp_box/feature/profile/view/email_otp_view.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/profile/widgets/build_edit_button.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';

class EpostaView extends StatefulWidget {
  const EpostaView({super.key});

  @override
  State<EpostaView> createState() => _EpostaViewState();
}

class _EpostaViewState extends State<EpostaView> {
  final TextEditingController _emailController = TextEditingController();

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
                _buildHeader(context),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'E-Posta Adresi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                  hintText: "E-posta adresiniz",
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: buildEditButton(context, _emailController,
                          onPressed: () {
                        context.read<ProfileBloc>().add(
                            ProfileChangeEmail(email: _emailController.text));
                        Navigator.of(context).pop();
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        BackButtonWidget(),
        Expanded(
          child: PageTitle(title: 'E-Posta'),
        ),
      ],
    );
  }
}
