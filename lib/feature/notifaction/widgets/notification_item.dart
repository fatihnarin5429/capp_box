import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String name;
  final String message;
  final String date;
  final String image;
  final String thumbnail;

  const NotificationItem({
    super.key,
    required this.name,
    required this.message,
    required this.date,
    required this.image,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                      height: 1.70,
                      letterSpacing: -0.50,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Color(0xFF84858E),
                      fontSize: 10,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      height: 1.70,
                      letterSpacing: -0.50,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Color(0xFF84858E),
                      fontSize: 8,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      height: 1.60,
                      letterSpacing: -0.30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(thumbnail),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
