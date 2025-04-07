import 'package:flutter/material.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';

class MediaSelectorButton extends StatelessWidget {
  final MediaType? type;
  final VoidCallback onTap;

  const MediaSelectorButton({
    Key? key,
    required this.type,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == MediaType.text
        ? const SizedBox()
        : Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 140,
              height: 44,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFFFFFFF)),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/Share.png',
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.share,
                            color: Colors.white,
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Seçiniz',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
