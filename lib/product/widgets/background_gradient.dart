import 'package:capp_box/product/constants/color_cons.dart';
import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1,
                colors: [
                  ColorConst.topLeftPurple2,
                  ColorConst.topLeftPurple1,
                  ColorConst.topLeftPurple1,
                  ColorConst.backgroundDark1,
                  ColorConst.backgroundDark1,
                  ColorConst.backgroundDark1,
                ],
                stops: [0.03, 0.3, 0.19, 0.87, 0.88, 0.9],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topCenter,
                colors: [
                  ColorConst.bottomRightPink,
                  ColorConst.backgroundDark1,
                ],
                stops: [0, 0.2],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
