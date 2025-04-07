import 'package:flutter/material.dart';

class TimerDisplayWidget extends StatelessWidget {
  const TimerDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '1:',
                  style: TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 12.33,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: 0.12,
                  ),
                ),
                Text(
                  'Saat',
                  style: TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 4.24,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '59:',
                  style: TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 12.33,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: 0.12,
                  ),
                ),
                Text(
                  'Dakika',
                  style: TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 4.24,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '50',
                  style: TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 12.33,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: 0.12,
                  ),
                ),
                Text(
                  'Saniye',
                  style: TextStyle(
                    color: Color(0xFF80B0C4),
                    fontSize: 4.24,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
