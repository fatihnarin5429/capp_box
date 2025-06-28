import 'package:flutter/material.dart';
import 'package:capp_box/feature/create_capsul/view/create_capsul_content_view.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';

class MediaTypeCard extends StatelessWidget {
  final String title;
  final String price;
  final String assetPath;
  final Color iconBackgroundColor;
  final Color iconColor;
  final MediaType type;

  const MediaTypeCard({
    super.key,
    required this.title,
    required this.price,
    required this.assetPath,
    required this.iconBackgroundColor,
    this.iconColor = Colors.white,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Geçiş işlemini bir sonraki frame'e ertele
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => CreateCapsulContentView(
                      controller: TextEditingController(),
                      onChanged: (String) {},
                      type: type,
                    ),
              ),
            );
          });
        },
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF262742),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDFADEB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(assetPath, color: iconColor),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
