import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/create_capsul/widgets/continue_button.dart';
import 'package:capp_box/feature/home/view/capsules_view.dart';
import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class CapsuleBuyView extends StatefulWidget {
  const CapsuleBuyView({Key? key}) : super(key: key);

  @override
  State<CapsuleBuyView> createState() => _CapsuleBuyViewState();
}

class _CapsuleBuyViewState extends State<CapsuleBuyView> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.maybePop(context);
                        },
                      ),
                      centerTitle: true,
                      title: const Text(
                        "Ödeme Yap",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 200,
                        child: Stack(
                          children: [
                            CreditCardWidget(
                              cardNumber: cardNumber,
                              bankName: 'Capp Box',
                              expiryDate: expiryDate,
                              cardHolderName: cardHolderName == ""
                                  ? "İsim Soyisim"
                                  : cardHolderName,
                              cvvCode: cvvCode,
                              showBackView: isCvvFocused,
                              obscureCardNumber: false,
                              obscureCardCvv: false,
                              isHolderNameVisible: true,
                              glassmorphismConfig:
                                  Glassmorphism.defaultConfig(),
                              labelValidThru: 'SKT',
                              frontCardBorder: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              backCardBorder: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              padding: 10,
                              cardBgColor: const Color(0xFF1C1D31),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              isSwipeGestureEnabled: true,
                              onCreditCardWidgetChange: (_) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CreditCardForm(
                              formKey: formKey,
                              obscureCvv: false,
                              obscureNumber: false,
                              cardNumber: cardNumber,
                              cvvCode: cvvCode,
                              isHolderNameVisible: true,
                              isCardNumberVisible: true,
                              isExpiryDateVisible: true,
                              cardHolderName: cardHolderName,
                              expiryDate: expiryDate,
                              onCreditCardModelChange: onCreditCardModelChange,
                              inputConfiguration: InputConfiguration(
                                cardNumberTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                ),
                                cvvCodeTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                ),
                                expiryDateTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                ),
                                cardHolderTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                ),
                                cardNumberDecoration: InputDecoration(
                                  labelText: 'Kart Numarası',
                                  hintText: '16 haneli kart numarasını giriniz',
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF84858E),
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    height: 1.70,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFF262742),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                cvvCodeDecoration: InputDecoration(
                                  labelText: 'CVV',
                                  hintText: '3 haneli güvenlik kodu',
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF84858E),
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    height: 1.70,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFF262742),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                expiryDateDecoration: InputDecoration(
                                  labelText: 'Son Kullanma Tarihi',
                                  hintText: 'AA/YY',
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF84858E),
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    height: 1.70,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFF262742),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                cardHolderDecoration: InputDecoration(
                                  labelText: 'Kart Üzerindeki İsim',
                                  hintText: 'Kart sahibinin adı',
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF84858E),
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    height: 1.70,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFF262742),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Container(
                                color: Colors.white.withOpacity(0.15),
                                width: MediaQuery.of(context).size.width * 0.85,
                              ),
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
                                  context
                                      .read<CreateCapsuleBloc>()
                                      .add(AddCreatedCapsules(
                                        createCapsuleModel:
                                            state.createCapsuleModel,
                                      ));
                                  context.read<CreateCapsuleBloc>().add(
                                        ResetCreateCapsuleModel(),
                                      );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CapsuleView(),
                                    ),
                                  );
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

  void onCreditCardModelChange(CreditCardModel? model) {
    if (model != null) {
      setState(() {
        cardNumber = model.cardNumber;
        expiryDate = model.expiryDate;
        cardHolderName = model.cardHolderName;
        cvvCode = model.cvvCode;
        isCvvFocused = model.isCvvFocused;
      });
    }
  }
}
