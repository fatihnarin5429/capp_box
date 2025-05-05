import 'package:capp_box/feature/create_capsul/view/create_capsul_view.dart';
import 'package:capp_box/feature/home/view/home_view.dart';
import 'package:capp_box/feature/package/widgets/custom_navigation_bar.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/feature/home/view/capsules_view.dart';
import 'package:capp_box/feature/notifaction/notifaction_view.dart';
import 'package:capp_box/feature/profile/view/profil_view.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      print('currenindex: $_currentIndex');
    });
  }

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: PopScope(
        canPop: false,
        child: BlocBuilder<CreateCapsuleBloc, CreateCapsuleState>(
          builder: (context, state) {
            print('state6: ${state.myCreatedCapsules}');

            _pages = [
              state.myCreatedCapsules.isNotEmpty
                  ? const HomeView2()
                  : const HomeView(),
              const CapsuleView(),
              const NotificationView(),
              const ProfilView(),
            ];

            return Scaffold(
              extendBody: true,
              body: _pages[_currentIndex],
              bottomNavigationBar: CustomNavigationBar(
                initialIndex: _currentIndex,
                onTap: _onPageChanged,
              ),
            );
          },
        ),
      ),
    );
  }
}
