import 'package:capp_box/core/extensions/localization_extension.dart';
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
        Text(
          context.tr('display_name'),
          style: const TextStyle(
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
          hintText: context.tr('display_name'),
          onChanged: (value) {},
        ),
        const SizedBox(height: 24),
        Text(
          context.tr('mail_address'),
          style: const TextStyle(
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
          hintText: context.tr('mail_address'),
          onChanged: (value) {},
        ),
        const SizedBox(height: 24),
        Text(
          context.tr('phone_number'),
          style: const TextStyle(
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
          hintText: context.tr('phone_number'),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
