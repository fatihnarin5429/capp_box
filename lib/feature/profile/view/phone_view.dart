import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/feature/profile/view/phone_otp_view.dart';
import 'package:capp_box/feature/profile/widgets/build_edit_button.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';

class PhoneView extends StatefulWidget {
  const PhoneView({super.key});

  @override
  State<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(
      text: context.read<ProfileBloc>().state.phone,
    );
  }

  @override
  void didUpdateWidget(PhoneView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _phoneController.text = context.read<ProfileBloc>().state.phone;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        _phoneController.text = state.phone ?? "5XX XXX XX XX";
        return Scaffold(
          body: Stack(
            children: [
              const BackgroundGradient(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      _buildHeader(context),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Telefon Numarası',
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
                        textInputType: TextInputType.phone,
                        controller: _phoneController,
                        hintText: "5XX XXX XX XX",
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          context.read<ProfileBloc>().add(
                            ProfileChangePhone(phone: value),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: _buildSaveButton(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        BackButtonWidget(),
        Expanded(child: PageTitle(title: 'Telefon Numarası')),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return BuilEditButton(
      targetRouteOnpressed: () {
        context.read<ProfileBloc>().add(
          ProfileChangePhone(phone: _phoneController.text),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PhoneOtpView(phoneNumber: _phoneController.text),
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
