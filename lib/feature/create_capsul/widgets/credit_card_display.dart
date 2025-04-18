import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

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

class CreditCardDisplay extends StatelessWidget with CreditCardInfoMixin {
  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      cardNumber: cardNumber,
      bankName: 'Capp Box',
      expiryDate: expiryDate,
      cardHolderName: cardHolderName == "" ? "İsim Soyisim" : cardHolderName,
      cvvCode: cvvCode,
      showBackView: isCvvFocused,
      obscureCardNumber: false,
      obscureCardCvv: false,
      isHolderNameVisible: true,
      glassmorphismConfig: Glassmorphism.defaultConfig(),
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
    );
  }
}
