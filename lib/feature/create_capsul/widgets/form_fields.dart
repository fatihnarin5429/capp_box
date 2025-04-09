import 'package:flutter/material.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';

class FormFields extends StatelessWidget {
  final TextEditingController displayNameController;
  final TextEditingController mailController;
  final TextEditingController phoneController;

  const FormFields({
    Key? key,
    required this.displayNameController,
    required this.mailController,
    required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ad Soyad',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          textInputType: TextInputType.name,
          controller: displayNameController,
          hintText: 'Ad Soyad',
          onChanged: (value) {},
        ),
        const SizedBox(height: 24),
        const Text(
          'Mail Adresi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          textInputType: TextInputType.emailAddress,
          controller: mailController,
          hintText: 'Mail Adresi',
          onChanged: (value) {},
        ),
        const SizedBox(height: 24),
        const Text(
          'Telefon Numarası',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          textInputType: TextInputType.phone,
          controller: phoneController,
          hintText: 'Telefon Numarası',
          onChanged: (value) {},
        ),
      ],
    );
  }
}
