import 'package:flutter/material.dart';

class PickerConstants {
  // Colors
  static const Color primaryBackground = Color(0xFF1F2232);
  static const Color secondaryBackground = Color(0xFF262742);
  static const Color borderColor = Color(0xFF484E50);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFC4C4C4);
  static const Color gradientStart = Color(0xFFB224EF);
  static const Color gradientEnd = Color(0xFF7579FF);

  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientStart, gradientEnd],
  );

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    color: textPrimary,
    fontSize: 18,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w600,
  );

  static const TextStyle labelStyle = TextStyle(
    color: textSecondary,
    fontSize: 12,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w500,
  );

  static const TextStyle selectedItemStyle = TextStyle(
    color: textPrimary,
    fontSize: 18,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w600,
  );

  static const TextStyle unselectedItemStyle = TextStyle(
    color: textSecondary,
    fontSize: 14,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle buttonStyle = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );

  static const TextStyle displayStyle = TextStyle(
    color: textPrimary,
    fontSize: 16,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w500,
  );

  // Dimensions
  static const double containerBorderRadius = 20.0;
  static const double buttonBorderRadius = 20.0;
  static const double itemBorderRadius = 8.0;
  static const double pickerHeight = 120.0;
  static const double itemHeight = 30.0;
  static const double containerPadding = 16.0;
  static const double buttonPadding = 10.0;
  static const double itemMargin = 8.0;

  // Picker Settings
  static const double wheelPerspective = 0.003;
  static const double wheelDiameterRatio = 1.5;
}
