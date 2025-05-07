import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/create_capsul/widgets/billing_info_form_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/continue_button.dart';
import 'package:capp_box/feature/home/view/capsules_view.dart';
import 'package:capp_box/feature/home/view/home_page.dart';
import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:capp_box/feature/create_capsul/widgets/credit_card_display.dart';
import 'package:capp_box/feature/create_capsul/widgets/credit_card_form_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/app_bar_widget.dart';

// Create a mixin for credit card information
mixin CreditCardInfoMixin {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void onCreditCardModelChange(CreditCardModel? model) {
    if (model != null) {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    }
  }
}

// Update the CapsuleBuyView to use the new widgets
class CapsuleBuyView extends StatefulWidget {
  const CapsuleBuyView({Key? key}) : super(key: key);

  @override
  State<CapsuleBuyView> createState() => _CapsuleBuyViewState();
}

class _CapsuleBuyViewState extends State<CapsuleBuyView>
    with CreditCardInfoMixin {
  final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> billingFormKey = GlobalKey<FormState>();
  bool isBillingInfoValid = false;

  void _onBillingInfoValidityChanged(bool isValid) {
    setState(() {
      isBillingInfoValid = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: BlocBuilder<CreateCapsuleBloc, CreateCapsuleState>(
        builder: (context, state) {
          return Stack(
            children: [
              const BackgroundGradient(),
              SafeArea(
                child: Column(
                  children: [
                    AppBarWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 200,
                        child: CreditCardDisplay(),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CreditCardFormWidget(formKey: cardFormKey),
                            _buildSeparator(),
                            BillingInfoFormWidget(
                              formKey: billingFormKey,
                              onValidityChanged: _onBillingInfoValidityChanged,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 32.0),
                              child: ContinueButton(
                                displayNameController: TextEditingController(),
                                mailController: TextEditingController(),
                                phoneController: TextEditingController(),
                                videoFile: null,
                                photoFile: null,
                                audioFile: null,
                                type: null,
                                selectedFileName: null,
                                secilenTip: null,
                                onPressed: () {
                                  // Form doğrulamasını kontrol et
                                  final isCardFormValid =
                                      cardFormKey.currentState?.validate() ??
                                          false;
                                  final isBillingFormValid =
                                      billingFormKey.currentState?.validate() ??
                                          false;

                                  if (isCardFormValid && isBillingInfoValid) {
                                    context
                                        .read<CreateCapsuleBloc>()
                                        .add(AddCreatedCapsules(
                                          createCapsuleModel:
                                              state.createCapsuleModel,
                                        ));
                                    context.read<CreateCapsuleBloc>().add(
                                          ResetCreateCapsuleModel(),
                                        );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(
                                          initialIndex: 1,
                                        ),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.15),
            width: MediaQuery.of(context).size.width * 0.85,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
