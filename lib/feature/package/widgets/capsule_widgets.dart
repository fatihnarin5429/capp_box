import 'package:capp_box/feature/create_capsul/view/my_created_capsules_view.dart';
import 'package:flutter/material.dart';

class CapsuleBackground extends StatelessWidget {
  const CapsuleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.1),
        ),
      ],
    );
  }
}

class CapsuleTitle extends StatelessWidget {
  const CapsuleTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Kapsüllerim',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600,
        height: 1.40,
      ),
    );
  }
}

class CapsuleFilterButtons extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onFilterSelected;

  const CapsuleFilterButtons({
    super.key,
    required this.selectedIndex,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilterButton(
            text: '📮 Tümü',
            isSelected: selectedIndex == 0,
            width: 180,
            onTap: () => onFilterSelected(0),
          ),
          const SizedBox(width: 12),
          FilterButton(
            text: '📦 Kapsüllerim',
            isSelected: selectedIndex == 3,
            width: 180,
            onTap: () => onFilterSelected(3),
          ),
          const SizedBox(width: 12),
          FilterButton(
            text: '⏳ Yakında',
            isSelected: selectedIndex == 1,
            width: 180,
            onTap: () => onFilterSelected(1),
          ),
          const SizedBox(width: 12),
          FilterButton(
            text: '🔓 Hazır',
            isSelected: selectedIndex == 2,
            width: 180,
            onTap: () => onFilterSelected(2),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final double width;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 40,
        decoration: ShapeDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.80, color: Color(0x7F7F7F7F)),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 16,
              fontFamily: 'Outfit',
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
