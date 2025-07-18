import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/view/create_capsul_content_view.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/capsule_options_list.dart';
import 'package:capp_box/feature/create_capsul/widgets/continue_button.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCapsuleChooseView extends StatefulWidget {
  const CreateCapsuleChooseView({super.key});

  @override
  State<CreateCapsuleChooseView> createState() =>
      _CreateCapsuleChooseViewState();
}

class _CreateCapsuleChooseViewState extends State<CreateCapsuleChooseView> {
  bool premiumOdendi = true; // Bu değer ödeme durumuna göre yönetilmeli

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundGradient(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButtonWidget(),
                        Expanded(
                          child: PageTitle(
                            title: context.tr('create_capsule', args: {}),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CapsuleOptionsList(),
                          BlocBuilder<CreateCapsuleBloc, CreateCapsuleState>(
                            builder: (context, state) {
                              return ContinueButton(
                                onPressed: () {
                                  context.read<CreateCapsuleBloc>().add(
                                    CreateCapsuleBodyAction(
                                      state.createCapsuleBodyModel!.copyWith(
                                        price:
                                            state.mediaType == MediaType.text
                                                ? 0
                                                : state.mediaType ==
                                                    MediaType.video
                                                ? 449.99
                                                : state.mediaType ==
                                                    MediaType.voice
                                                ? 149.99
                                                : state.mediaType ==
                                                    MediaType.photo
                                                ? 249.99
                                                : 0,
                                      ),
                                    ),
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => CreateCapsulContentView(
                                              type: state.mediaType,
                                              controller: TextEditingController(),
                                              onChanged: (value) {},
                                            ),
                                      ),
                                    );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
