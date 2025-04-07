import 'package:flutter/material.dart';

class InfoSharingOptions extends StatelessWidget {
  final bool shareInfo;
  final Function(bool) onShareInfoChanged;

  const InfoSharingOptions({
    Key? key,
    required this.shareInfo,
    required this.onShareInfoChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bilgilerin karşı tarafa verilsin mi?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
              height: 1.40,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () => onShareInfoChanged(true),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: shareInfo
                        ? const LinearGradient(
                            colors: [
                              Color(0xFFE0AEEC),
                              Color(0xFF445BD1),
                            ],
                          )
                        : null,
                    border: shareInfo
                        ? null
                        : Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                  ),
                  child: shareInfo
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Verilsin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () => onShareInfoChanged(false),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: !shareInfo
                        ? const LinearGradient(
                            colors: [
                              Color(0xFFE0AEEC),
                              Color(0xFF445BD1),
                            ],
                          )
                        : null,
                    border: !shareInfo
                        ? null
                        : Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                  ),
                  child: !shareInfo
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Bilgilerim gizli kalsın',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
