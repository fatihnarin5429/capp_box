import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/home/bloc/home_bloc.dart';
import 'package:capp_box/feature/home/view/home_view.dart';
import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/feature/home/view/capsules_view.dart' as capsules_view;
import 'package:capp_box/feature/notifaction/notifaction_view.dart';
import 'package:capp_box/feature/profile/view/profil_view.dart';
import 'package:capp_box/feature/package/widgets/custom_navigation_bar.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    // Sadece event dispatch et, başka bir şey yapma
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeGetCapsules());
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Çıkmak istediğinize emin misiniz?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Hayır'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Evet'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final homeBlocState = context.watch<HomeBloc>().state;
    final pages = [
      (homeBlocState.capsules?.isEmpty ?? true)
          ? const HomeView()
          : const HomeView2(),
      const capsules_view.CapsuleView(),
      const NotificationView(),
      const ProfilView(),
    ];

    return Scaffold(
      extendBody: true,
      body: pages[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        initialIndex: _currentIndex,
        onTap: _onPageChanged,
      ),
    );
  }
}
