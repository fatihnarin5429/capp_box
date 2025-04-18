import 'package:capp_box/feature/home/widgets/capsule_card.dart';
import 'package:capp_box/feature/home/widgets/timer_display_widget.dart';
import 'package:capp_box/feature/package/widgets/capsule_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_capsule/feature/home/bloc/create_capsule_bloc.dart';
import 'package:time_capsule/feature/home/widgets/background_gradient.dart';
import 'package:time_capsule/feature/home/widgets/capsule_card.dart';
import 'package:time_capsule/feature/home/widgets/capsule_filter_buttons.dart';
import 'package:time_capsule/feature/home/widgets/capsule_title.dart';
import 'package:time_capsule/feature/home/widgets/timer_display_widget.dart';
import 'package:time_capsule/feature/navigation/custom_navigation_bar.dart';

import '../../../product/widgets/background_gradient.dart';
import '../../create_capsul/bloc/create_capsule_bloc.dart';
import 'package:your_package_name/path_to_file_containing_capsule.dart';

class Capsule {
  // Define properties and methods for the Capsule class
}

class CapsulesViewWidget extends StatefulWidget {
  @override
  _CapsulesViewWidgetState createState() => _CapsulesViewWidgetState();
}

class _CapsulesViewWidgetState extends State<CapsulesViewWidget> {
  late PageController _pageController;
  int _selectedIndex = 0;
  int _currentPage = 0;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: NavigationBar(
        selectedIndex: 2,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box),
            label: 'Kapsül Oluştur',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time),
            label: 'Kapsüllerim',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
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
                              ? 'Tüm Kapsüller'
                              : _selectedIndex == 1
                                  ? 'Yakında Açılacak Kapsüller'
                                  : _selectedIndex == 2
                                      ? 'Açılmaya Hazır Kapsüller'
                                      : 'Benim Oluşturduğum Kapsüller',
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
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 32.0),
                            child: Text(
                              'Henüz hiç kapsül oluşturmadınız',
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
                                  ? 'Yakında açılacak kapsül bulunmamaktadır'
                                  : _selectedIndex == 2
                                      ? 'Açılmaya hazır kapsül bulunmamaktadır'
                                      : _selectedIndex == 3
                                          ? 'Henüz kapsül oluşturmadınız'
                                          : 'Kapsül bulunmamaktadır',
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

  void _showCapsulePopup(BuildContext context, {required Capsule capsule}) {
    // Implementation of _showCapsulePopup method
  }
}
