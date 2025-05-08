// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:capp_box/core/extensions/localization_extension.dart';

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

class CreditCardFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const CreditCardFormWidget({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  State<CreditCardFormWidget> createState() => _CreditCardFormWidgetState();
}

class _CreditCardFormWidgetState extends State<CreditCardFormWidget>
    with CreditCardInfoMixin {
  @override
  void initState() {
    super.initState();
    // updateState fonksiyonunu burada tanımla
    updateState = setState;
  }

  @override
  Widget build(BuildContext context) {
    return CreditCardForm(
      formKey: widget.formKey,
      obscureCvv: true,
      obscureNumber: true,
      cardNumber: cardNumber,
      cvvCode: cvvCode,
      isHolderNameVisible: true,
      isCardNumberVisible: true,
      isExpiryDateVisible: true,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      // Her zaman null döndür = doğrulama yok
      expiryDateValidator: (_) => null,
      cardNumberValidator: (_) => null,
      cvvValidator: (_) => null,
      cardHolderValidator: (_) => null,
      onCreditCardModelChange: onCreditCardModelChange,
      dateValidationMessage: '',
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
          labelText: context.tr('card_number', args: {}),
          hintText: context.tr('card_number_message', args: {}),
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
          labelText: context.tr('cvv', args: {}),
          hintText: context.tr('cvv_message', args: {}),
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
          labelText: context.tr('expiration_date', args: {}),
          hintText: context.tr('expiration_date_message', args: {}),
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
          labelText: context.tr('card_holder_name', args: {}),
          hintText: context.tr('card_holder_name_message', args: {}),
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
    );
  }
}
