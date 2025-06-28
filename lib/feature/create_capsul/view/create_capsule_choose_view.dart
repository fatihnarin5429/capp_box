import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/view/create_capsul_content_view.dart';

import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/capsule_options_list.dart';
import 'package:capp_box/feature/create_capsul/widgets/continue_button.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

class CreateCapsuleChooseView extends StatefulWidget {
  const CreateCapsuleChooseView({super.key});

  @override
  State<CreateCapsuleChooseView> createState() =>
      _CreateCapsuleChooseViewState();
}

class _CreateCapsuleChooseViewState extends State<CreateCapsuleChooseView> {
  MediaType? secilenTip;
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
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CapsuleOptionsList(
                              secilenTip: secilenTip,
                              premiumOdendi: premiumOdendi,
                              onTipSecildi:
                                  (tip) => setState(() => secilenTip = tip),
                            ),
                            ContinueButton(
                              secilenTip: secilenTip,
                              displayNameController: TextEditingController(),
                              mailController: TextEditingController(),
                              phoneController: TextEditingController(),
                              onPressed: () {
                                if (secilenTip == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Lütfen bir tip seçin'),
                                      duration: Duration(seconds: 1),
                                      behavior: SnackBarBehavior.fixed,
                                      backgroundColor:
                                          ColorConst.backgroundPurple1,
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => CreateCapsulContentView(
                                            controller: TextEditingController(),
                                            onChanged: (value) {},
                                            type: secilenTip,
                                          ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
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
