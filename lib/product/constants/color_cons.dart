import 'package:flutter/material.dart';

class ColorConst {
  ColorConst._();

  // Ana arka plan rengi - koyu lacivert/gri ton
  static const Color backgroundColor = Color(0xFF1C1D31);

  static const Color primaryPurple = Color(0xFF8B3DFF);

  // Gradient renkleri
  static const Color gradientStart = Color(0xFF9B23E1); // Parlak mor üst
  static const Color gradientMiddle1 = Color(0xFF7B20C9); // Orta mor
  static const Color gradientMiddle2 = Color(0xFF4B1D8F); // Koyu mor
  static const Color gradientEnd = Color(0xFF1A1A2E); // Koyu lacivert alt

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      gradientStart,
      gradientMiddle1,
      gradientMiddle2,
      gradientEnd,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.2, 0.4, 0.9],
  );

  // Sağ üst köşe için radial gradient
  static const RadialGradient topRightGlow = RadialGradient(
    center: Alignment(0.8, 0.8), // Sağ üst köşeye yakın
    radius: 0.7,
    colors: [
      Color.fromARGB(255, 47, 15,
          93), // Çok daha koyu mor (sol üstteki 9B23E1'den daha koyu)
      Color(0x00371568), // Saydam
    ],
    stops: [0.0, 1.0],
  );

  // Sol üst köşe için yeni renkler
  static const Color topLeftPurple1 = Color(0xFF9B23E1);
  static const Color topLeftPurple2 = Color(0xFF5F05F0);
  static const Color bottomRightPink = Color(0xFFE12395);

  // Sol üst köşe için radial gradient
  static const RadialGradient topLeftGlow = RadialGradient(
    center: Alignment(-0.8, -0.8), // Sol üst köşeye yakın
    radius: 0.7,
    colors: [
      topLeftPurple1,
      topLeftPurple2,
      Color(0xFF371568), // Koyu mor
      Color(0x00371568), // Saydam koyu mor
    ],
    stops: [0.0, 0.2, 0.4, 1.0],
  );

  // Arka plan renkleri
  static const Color backgroundPurple1 = Color(0xFF5F05F0);
  static const Color backgroundPurple2 = Color(0xFF9B23E1);
  static const Color backgroundDark1 = Color(0xFF1F2232);
}
