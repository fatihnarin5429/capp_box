import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/home/view/capsules_view.dart';
import 'package:capp_box/feature/home/view/home_view.dart';
import 'package:capp_box/feature/notifaction/notifaction_view.dart';
import 'package:capp_box/feature/profile/view/profil_view.dart';

class CustomNavigationBar extends StatefulWidget {
  final int initialIndex;
  final Function(int)? onTap;
  const CustomNavigationBar({
    super.key,
    required this.initialIndex,
    this.onTap,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const HomeView2(),
    const CapsuleView(),
    const NotificationView(),
    const ProfilView(),
    const HomeView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: const Color(0xFF2B2B3D),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, 'assets/icons/home.png'),
          _buildNavItem(1, 'assets/icons/Group.png'),
          _buildAddButton(),
          _buildNavItem(2, 'assets/icons/Alert.png'),
          _buildNavItem(3, 'assets/icons/Profile.png'),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/create_capsul_view');
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Image.asset(
        iconPath,
        color: isSelected ? Colors.white : Colors.grey,
        width: 24,
        height: 24,
      ),
    );
  }
}
