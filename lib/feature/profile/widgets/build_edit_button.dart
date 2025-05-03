import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class BuilEditButton extends StatefulWidget {
  final VoidCallback targetRouteOnpressed;
  const BuilEditButton({super.key, required this.targetRouteOnpressed});

  @override
  State<BuilEditButton> createState() => _BuilEditButtonState();
}

class _BuilEditButtonState extends State<BuilEditButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: widget.targetRouteOnpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(1.00, 0.00),
              end: Alignment(-1, 0),
              colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              context.tr('edit'),
              style: const TextStyle(
                color: Color(0xFFE5E5E5),
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
