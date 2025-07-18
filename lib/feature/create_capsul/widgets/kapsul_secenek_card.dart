import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:flutter/material.dart';

class KapsulSecenekCard extends StatelessWidget {
  final String icon;
  final String baslik;
  final String fiyat;
  final MediaType tip;
  final VoidCallback onTap;
  final bool secili;

  const KapsulSecenekCard({
    Key? key,
    required this.icon,
    required this.baslik,
    required this.fiyat,
    required this.tip,
    required this.onTap,
    required this.secili,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 335,
          height: 67,
          decoration: ShapeDecoration(
            color: const Color(0xFF262741),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            children: [
              if (secili) // Sadece seçili olana radio ekle
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE0AEEC), Color(0xFF445BD1)],
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (secili) const SizedBox(), // Seçiliyse boşluk ekle
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Image.asset(icon),
              ),
              const SizedBox(
                  width: 10), // İkonlar arasına daha fazla boşluk ekle
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${baslik} ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  fiyat,
                  style: TextStyle(
                    color: fiyat == context.tr('capsule_option_free', args: {})
                        ? Colors.white
                        : const Color(0xFFFF15A2),
                    fontSize: 16,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
