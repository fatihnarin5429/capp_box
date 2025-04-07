import 'package:flutter/material.dart';

class CapsuleProgressBar extends StatelessWidget {
  final int currentStep;

  const CapsuleProgressBar({
    Key? key,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                color: currentStep >= 0
                    ? const Color(0xFFA737FF)
                    : const Color(0xFF351250),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          // ... diğer progress bar parçaları
        ],
      ),
    );
  }
}
