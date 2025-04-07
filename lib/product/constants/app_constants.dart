import 'package:flutter/material.dart';

class AppConstants {
  static const backgroundGradient = BoxDecoration(
    gradient: RadialGradient(
      center: Alignment.topLeft,
      radius: 1,
      colors: [
        Color(0xFF5F05F0),
        Color(0xFF9B23E1),
        Color(0xFF9B23E1),
        Color(0xFF1C1C1E),
        Color(0xFF1C1C1E),
        Color(0xFF1C1C1E),
      ],
      stops: [0.03, 0.3, 0.19, 0.87, 0.88, 0.9],
    ),
  );

  static const titleStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w600,
  );

  static const headingStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w800,
    height: 1.50,
  );

  static const bodyStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w400,
    height: 1.60,
  );

  static const featureStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w400,
    height: 1.60,
  );

  static const priceLabelStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w400,
  );

  static const priceValueStyle = TextStyle(
    color: Color(0xFFFF15A1),
    fontSize: 16,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w400,
  );

  static const buttonGradient = LinearGradient(
    begin: Alignment(1.00, 0.00),
    end: Alignment(-1, 0),
    colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
  );
}
