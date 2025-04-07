import 'package:capp_box/feature/create_capsul/view/create_capsul_view.dart';
import 'package:capp_box/feature/package/widgets/custom_navigation_bar.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/feature/home/view/capsules_view.dart';
import 'package:capp_box/feature/notifaction/notifaction_view.dart';
import 'package:capp_box/feature/profile/view/profil_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeView2(),
    const CapsuleView(),
    const NotificationView(),
    const ProfilView(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true,
        body: _pages[_currentIndex],
        bottomNavigationBar: CustomNavigationBar(
          initialIndex: _currentIndex,
          onTap: _onPageChanged,
        ),
      ),
    );
  }
}
