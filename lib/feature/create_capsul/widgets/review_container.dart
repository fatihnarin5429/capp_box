import 'package:flutter/material.dart';

class ReviewContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double? height;
  final double? padding;

  const ReviewContainer(
      {super.key,
      required this.child,
      this.width = 338,
      this.height,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding ?? 12),
      decoration: ShapeDecoration(
        color: const Color(0xFF262742),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: child,
    );
  }
}
