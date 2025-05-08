import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

mixin CreditCardInfoMixin {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  // UI güncellemesi için fonksiyon
  Function(Function())? updateState;

  void onCreditCardModelChange(CreditCardModel? model) {
    if (model != null) {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;

      // updateState fonksiyonu varsa çağır
      updateState?.call(() {});
    }
  }
}

class CreditCardDisplay extends StatefulWidget {
  const CreditCardDisplay({Key? key}) : super(key: key);

  @override
  State<CreditCardDisplay> createState() => _CreditCardDisplayState();
}

class _CreditCardDisplayState extends State<CreditCardDisplay>
    with CreditCardInfoMixin {
  @override
  void initState() {
    super.initState();
    updateState = setState;
  }

  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      cardNumber: cardNumber,
      bankName: 'Capp Box',
      expiryDate: expiryDate,
      cardHolderName: cardHolderName == ""
          ? context.tr('full_name', args: {})
          : cardHolderName,
      cvvCode: cvvCode,
      showBackView: isCvvFocused,
      obscureCardNumber: false,
      obscureCardCvv: false,
      isHolderNameVisible: true,
      glassmorphismConfig: Glassmorphism.defaultConfig(),
      labelValidThru: context.tr('SKT', args: {}),
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
