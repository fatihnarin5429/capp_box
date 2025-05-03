import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/home/widgets/capsule_card.dart';
import 'package:capp_box/feature/home/widgets/timer_display_widget.dart';
import 'package:capp_box/feature/package/widgets/capsule_widgets.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:capp_box/product/widgets/time_component.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/package/widgets/custom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class CapsuleView extends StatefulWidget {
  const CapsuleView({super.key});

  @override
  State<CapsuleView> createState() => _CapsuleViewState();
}

class _CapsuleViewState extends State<CapsuleView> {
  int _selectedIndex = 0;
  int _currentPage = 0;

  final PageController _pageController = PageController(
    viewportFraction: 0.9,
  );

  late final AnimatedMeshGradientController _controller =
      AnimatedMeshGradientController();

  @override
  void initState() {
    _controller.start();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _showCapsulePopup(BuildContext context,
      {required CreateCapsuleModel capsule}) {
    final isReadyToOpen = capsule.openedDate != null &&
        int.parse(capsule.openedDate!) <= DateTime.now().millisecondsSinceEpoch;

    final openDate = capsule.openedDate != null
        ? DateTime.fromMillisecondsSinceEpoch(int.parse(capsule.openedDate!))
        : null;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF10101C),
        insetPadding: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF10101C),
                const Color(0xFF262742).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    isReadyToOpen
                        ? 'assets/icons/kapsul_without_bg.png'
                        : 'assets/images/kilitkapsul.png',
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.contain,
                  ),
                  if (!isReadyToOpen && openDate != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TimeComponent(
                              value:
                                  '${openDate.hour.toString().padLeft(2, '0')}:',
                              label: 'Saat',
                            ),
                            TimeComponent(
                              value:
                                  '${openDate.minute.toString().padLeft(2, '0')}:',
                              label: 'Dakika',
                            ),
                            TimeComponent(
                              value: openDate.second.toString().padLeft(2, '0'),
                              label: 'Saniye',
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                isReadyToOpen
                    ? 'Tebrikler! Kapsülünüz açılmaya hazır'
                    : 'Kapsülünüzün açılma\ntarihi henüz gelmedi.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isReadyToOpen
                    ? 'Hadi hemen ne gönderilmiş kontrol edelim!'
                    : openDate != null
                        ? '${openDate.day.toString().padLeft(2, '0')}.${openDate.month.toString().padLeft(2, '0')}.${openDate.year} tarihinde kapsülü\naçabilirsiniz.'
                        : 'Kapsülün açılma tarihi belirlenmemiş.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(1.00, 0.00),
                      end: const Alignment(-1, 0),
                      colors: [
                        const Color(0xFFB224EF),
                        const Color(0xFF7579FF).withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      'Kapat',
                      style: TextStyle(
                        color: Color(0xFFE5E5E5),
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                          selectedIndex: _selectedIndex,
                          onFilterSelected: (index) {
                            setState(() => _selectedIndex = index);
                            context.read<CreateCapsuleBloc>().add(
                                  FilterCapsules(filterIndex: index),
                                );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          _selectedIndex == 0
                              ? context.tr('all_capsules')
                              : _selectedIndex == 1
                                  ? context.tr('coming_soon_capsules')
                                  : _selectedIndex == 2
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
                      if (state.myCreatedCapsules.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 32.0),
                            child: Text(
                              context.tr('no_capsules_created'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      else if (state.filteredCapsules.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: Text(
                              _selectedIndex == 1
                                  ? context.tr('coming_soon_capsules_message')
                                  : _selectedIndex == 2
                                      ? context
                                          .tr('ready_to_open_capsules_message')
                                      : _selectedIndex == 3
                                          ? context.tr('no_capsules_created')
                                          : context.tr('no_capsules_message'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: PageView.builder(
                            padEnds: false,
                            controller: _pageController,
                            itemCount: _selectedIndex == 3
                                ? state.myCreatedCapsules.length
                                : state.filteredCapsules.length,
                            onPageChanged: (index) =>
                                setState(() => _currentPage = index),
                            itemBuilder: (context, index) {
                              final capsule = _selectedIndex == 3
                                  ? state.myCreatedCapsules[index]
                                  : state.filteredCapsules[index];

                              final isCurrent = index == _currentPage;

                              final int? openedDateMillis =
                                  int.tryParse(capsule.openedDate ?? '');
                              final isReadyToOpen = openedDateMillis != null &&
                                  openedDateMillis <=
                                      DateTime.now().millisecondsSinceEpoch;

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: AnimatedScale(
                                  scale: isCurrent ? 1.0 : 0.9,
                                  duration: const Duration(milliseconds: 300),
                                  child: InkWell(
                                    onTap: () => _showCapsulePopup(context,
                                        capsule: capsule),
                                    child: CapsuleCard(
                                      senderName: capsule.displayName ?? '',
                                      imageUrl: "https://placehold.co/40x40",
                                      isReadyToOpen: isReadyToOpen,
                                      controller: _controller,
                                      timerWidget: const TimerDisplayWidget(),
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
            ],
          );
        },
      ),
    );
  }
}
