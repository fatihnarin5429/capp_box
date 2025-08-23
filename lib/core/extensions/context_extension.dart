import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // Screen dimensions
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  // Theme
  ThemeData get theme => Theme.of(this);

  // Padding values
  EdgeInsets get paddingHorizontalDefault =>
      const EdgeInsets.symmetric(horizontal: 16);
  EdgeInsets get paddingVerticalDefault =>
      const EdgeInsets.symmetric(vertical: 16);

  // Spacing values
  double get lowValue => 8;
  double get xLowValue => 4;
  double get defaultValue => 16;
}
