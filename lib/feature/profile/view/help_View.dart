import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart'
    show PageTitle;
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> helpItems = [
      {
        'title': context.tr('help_what_is', args: {}),
        'description': context.tr('help_what_is_description', args: {}),
      },
      {
        'title': context.tr('help_how_works', args: {}),
        'description': context.tr('help_how_works_description', args: {}),
      },
      {
        'title': context.tr('help_contact', args: {}),
        'description': context.tr('help_contact_description', args: {}),
      },
      {
        'title': context.tr('help_privacy_policy', args: {}),
        'description': context.tr('help_privacy_policy_description', args: {}),
      },
      {
        'title': context.tr('help_account', args: {}),
        'description': context.tr('help_account_description', args: {}),
      },
    ];

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
                        PageTitle(title: context.tr('help_title', args: {})),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: helpItems.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              decoration: ShapeDecoration(
                                color: const Color(0xFF24223D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  initiallyExpanded: false,
                                  maintainState: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  collapsedShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  title: Text(
                                    helpItems[index]['title']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF24223D)
                                            .withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        helpItems[index]['description']!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
