import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';

mixin BillingInfoMixin {
  String address = '';
  String city = '';
  String state = '';
  String postalCode = '';
  String country = '';

  // UI güncellemesi için fonksiyon
  Function(Function())? updateState;

  // Getters to check if fields are valid
  bool get isAddressValid => address.isNotEmpty;
  bool get isCityValid => city.isNotEmpty;
  bool get isStateValid => state.isNotEmpty;
  bool get isPostalCodeValid => postalCode.isNotEmpty;
  bool get isCountryValid => country.isNotEmpty;

  // Check if all billing info is valid
  bool get isBillingInfoValid =>
      isAddressValid &&
      isCityValid &&
      isStateValid &&
      isPostalCodeValid &&
      isCountryValid;
}

class BillingInfoFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(bool)? onValidityChanged;

  const BillingInfoFormWidget({
    Key? key,
    required this.formKey,
    this.onValidityChanged,
  }) : super(key: key);

  @override
  State<BillingInfoFormWidget> createState() => _BillingInfoFormWidgetState();
}

class _BillingInfoFormWidgetState extends State<BillingInfoFormWidget>
    with BillingInfoMixin {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  void _updateValidity() {
    if (widget.onValidityChanged != null) {
      widget.onValidityChanged!(isBillingInfoValid);
    }
  }

  @override
  void initState() {
    super.initState();

    // updateState fonksiyonunu tanımla
    updateState = setState;

    _addressController.addListener(() {
      setState(() {
        address = _addressController.text;
        _updateValidity();
      });
    });

    _cityController.addListener(() {
      setState(() {
        city = _cityController.text;
        _updateValidity();
      });
    });

    _stateController.addListener(() {
      setState(() {
        state = _stateController.text;
        _updateValidity();
      });
    });

    _postalCodeController.addListener(() {
      setState(() {
        postalCode = _postalCodeController.text;
        _updateValidity();
      });
    });

    _countryController.addListener(() {
      setState(() {
        country = _countryController.text;
        _updateValidity();
      });
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr('billing_information', args: {}),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildFieldLabel(context, 'address', args: {}),
          const SizedBox(height: 8),
          CustomTextField(
            textInputType: TextInputType.streetAddress,
            controller: _addressController,
            hintText: context.tr('address_hint', args: {}),
            maxLines: 2,
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(context, 'city', args: {}),
                    const SizedBox(height: 8),
                    CustomTextField(
                      textInputType: TextInputType.text,
                      controller: _cityController,
                      hintText: context.tr('city_hint', args: {}),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(context, 'state', args: {}),
                    const SizedBox(height: 8),
                    CustomTextField(
                      textInputType: TextInputType.text,
                      controller: _stateController,
                      hintText: context.tr('state_hint', args: {}),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(context, 'postal_code', args: {}),
                    const SizedBox(height: 8),
                    CustomTextField(
                      textInputType: TextInputType.number,
                      controller: _postalCodeController,
                      hintText: context.tr('postal_code_hint', args: {}),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(context, 'country', args: {}),
                    const SizedBox(height: 8),
                    CustomTextField(
                      textInputType: TextInputType.text,
                      controller: _countryController,
                      hintText: context.tr('country_hint', args: {}),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(BuildContext context, String key,
      {Map<String, String>? args}) {
    return Text(
      context.tr(key, args: args),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
