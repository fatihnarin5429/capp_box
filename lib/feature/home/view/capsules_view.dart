import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/home/mixins/capsule_view_mixin.dart';
import 'package:capp_box/feature/home/widgets/capsule_list_widget.dart';
import 'package:capp_box/feature/package/widgets/capsule_widgets.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/package/widgets/custom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CapsuleView extends StatefulWidget {
  const CapsuleView({super.key});

  @override
  State<CapsuleView> createState() => _CapsuleViewState();
}

class _CapsuleViewState extends State<CapsuleView> with CapsuleViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(initialIndex: 2),
      body: BlocBuilder<CreateCapsuleBloc, CreateCapsuleState>(
        builder: (context, state) {
          return Stack(
            children: [
              const BackgroundGradient(),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Center(child: CapsuleTitle()),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CapsuleFilterButtons(
                          selectedIndex: selectedIndex,
                          onFilterSelected: (index) {
                            setState(() => selectedIndex = index);
                            // context.read<CreateCapsuleBloc>().add(
                            //       FilterCapsules(filterIndex: index),
                            //     );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          selectedIndex == 0
                              ? context.tr('all_capsules')
                              : selectedIndex == 1
                              ? context.tr('coming_soon_capsules')
                              : selectedIndex == 2
                              ? context.tr('ready_to_open_capsules')
                              : context.tr('my_created_capsules'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CapsuleListWidget(
                        selectedIndex: selectedIndex,
                        pageController: pageController,
                        currentPage: currentPage,
                        onPageChanged:
                            (index) => setState(() => currentPage = index),
                        state: state,
                        controller: controller,
                        onCapsuleTap: showCapsulePopup,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
