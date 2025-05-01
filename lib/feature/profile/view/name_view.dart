import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';
import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';

import 'package:capp_box/feature/profile/view/profil_view.dart';
import 'package:capp_box/feature/profile/widgets/build_edit_button.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameView extends StatefulWidget {
  const NameView({super.key});

  @override
  State<NameView> createState() => _NameViewState();
}

class _NameViewState extends State<NameView> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        _nameController = TextEditingController(text: state.displayName);
        return Scaffold(
          body: Stack(
            children: [
              const BackgroundGradient(),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    children: [
                      _buildHeader(context),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Ad Soyad',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      CustomTextField(
                        textInputType: TextInputType.name,
                        controller: _nameController,
                        hintText: "Ad-Soyad",
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: _buildEditButton(context),
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
        Expanded(
          child: PageTitle(title: 'İsim Soyisim'),
        ),
      ],
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return buildEditButton(
      context,
      _nameController,
      onPressed: () {
        context
            .read<ProfileBloc>()
            .add(ProfileChangeName(displayName: _nameController.text));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilView()),
        );
      },
    );
  }
}
