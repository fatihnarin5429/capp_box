import 'package:capp_box/core/extensions/localization_extension.dart';
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

class CreditCardFormWidget extends StatelessWidget with CreditCardInfoMixin {
  final GlobalKey<FormState> formKey;

  CreditCardFormWidget({required this.formKey});

  @override
  Widget build(BuildContext context) {
    return CreditCardForm(
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
          labelText: context.tr('card_number'),
          hintText: context.tr('card_number_message'),
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
          labelText: context.tr('cvv'),
          hintText: context.tr('cvv_message'),
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
          labelText: context.tr('expiration_date'),
          hintText: context.tr('expiration_date_message'),
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
          labelText: context.tr('card_holder_name'),
          hintText: context.tr('card_holder_name_message'),
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
