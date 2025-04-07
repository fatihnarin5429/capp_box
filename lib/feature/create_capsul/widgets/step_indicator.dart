import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({
    Key? key,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: SizedBox(
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: currentStep >= 1
                      ? const Color(0xFFA737FF)
                      : const Color(0xFF351250),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: currentStep >= 2
                      ? const Color(0xFFA737FF)
                      : const Color(0xFF351250),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  color: currentStep >= 3
                      ? const Color(0xFFA737FF)
                      : const Color(0xFF351250),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
