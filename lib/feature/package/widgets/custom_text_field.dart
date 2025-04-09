import 'package:flutter/material.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final String? labelText;
  final bool isPassword;
  final Function(String)? onSubmitted;
  final bool isError;
  final String? errorText;
  final bool autofocus;
  final Function(bool)? onPasswordVisibilityChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextStyle? style;
  final Widget? prefix;
  final int? maxLines;
  final double? height;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.labelText,
    this.isPassword = false,
    this.isError = false,
    this.errorText,
    this.autofocus = false,
    this.onPasswordVisibilityChanged,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.style,
    this.prefix,
    this.maxLines = 1,
    this.height,
    this.textInputAction = TextInputAction.done,
    required TextInputType textInputType,
  });

  get width => null;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hasText = false;

  @override
  Widget build(BuildContext context) {
    return ZoAnimatedGradientBorder(
      borderRadius: widget.maxLines == 1 ? 100 : 15,
      borderThickness: hasText ? 5 : 0,
      glowOpacity: 0.2,
      gradientColor: hasText
          ? const [Color(0xFFE0AEEC), Color(0xFF445BD1)]
          : [Colors.transparent],
      duration: const Duration(seconds: 2),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: ShapeDecoration(
          color: const Color(0xFF262742),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.maxLines == 1 ? 99 : 14),
          ),
        ),
        child: TextField(
          controller: widget.controller,
          autofocus: widget.autofocus,
          obscureText: widget.isPassword,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onSubmitted: widget.onSubmitted ??
              (value) {
                setState(() {
                  hasText = value.isNotEmpty;
                });
                widget.onSubmitted?.call(value);
              },
          onChanged: widget.onChanged ??
              (value) {
                setState(() {
                  hasText = value.isNotEmpty;
                });
                widget.onChanged?.call(value);
              },
          style: widget.style ??
              const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
              ),
          decoration: InputDecoration(
            prefix: widget.prefix,
            hintText: widget.hintText,
            errorText: widget.isError ? widget.errorText : null,
            hintStyle: const TextStyle(
              color: Color(0xFF84858E),
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
              height: 1.70,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            border: InputBorder.none,
          ),
          maxLines: widget.maxLines,
        ),
      ),
    );
  }
}

class SmallCustomTextField extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final double width;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  const SmallCustomTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.width = 156,
    this.maxLines,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<SmallCustomTextField> createState() => _SmallCustomTextFieldState();
}

class _SmallCustomTextFieldState extends State<SmallCustomTextField> {
  bool hasText = false;
  @override
  Widget build(BuildContext context) {
    return ZoAnimatedGradientBorder(
      borderRadius: 100,
      borderThickness: hasText ? 4 : 0,
      glowOpacity: 0.1,
      gradientColor: hasText
          ? const [Color(0xFFE0AEEC), Color(0xFF445BD1)]
          : [Colors.transparent],
      duration: const Duration(seconds: 2),
      child: Container(
        width: widget.width,
        decoration: ShapeDecoration(
          color: const Color(0xFF262742),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.maxLines == 1 ? 99 : 14),
          ),
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              hasText = value.isNotEmpty;
            });
            widget.onChanged(value);
          },
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF84858E),
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
              height: 1.70,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
