import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

class GizlilikView extends StatefulWidget {
  const GizlilikView({super.key});

  @override
  State<GizlilikView> createState() => _GizlilikViewState();
}

class _GizlilikViewState extends State<GizlilikView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: BackButtonWidget(),
                        ),
                        PageTitle(title: context.tr('privacy_title', args: {})),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        context.tr('privacy_text', args: {}),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
