import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:capp_box/feature/home/service/model/capsule_model.dart';

class UpcomingCapsuleCard extends StatelessWidget {
  final Capsule capsule;
  final VoidCallback? onTap;

  const UpcomingCapsuleCard({Key? key, required this.capsule, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final daysRemaining = capsule.openingDate.difference(DateTime.now()).inDays;
    final dateFormatter = DateFormat('dd.MM.yyyy');

    Color cardColor;
    IconData mediaIcon;

    // Medya tipine göre ikon ve renk belirleme
    switch (capsule.mediaType.toLowerCase()) {
      case 'yazı':
        cardColor = const Color(0xFF4052EE);
        mediaIcon = Icons.article_outlined;
        break;
      case 'video':
        cardColor = const Color(0xFFD93B3B);
        mediaIcon = Icons.videocam_outlined;
        break;
      case 'ses':
        cardColor = const Color(0xFF58D65A);
        mediaIcon = Icons.mic_outlined;
        break;
      case 'fotoğraf':
        cardColor = const Color(0xFF9747FF);
        mediaIcon = Icons.photo_outlined;
        break;
      default:
        cardColor = const Color(0xFF4052EE);
        mediaIcon = Icons.article_outlined;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF262741),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Medya tipi ikonu
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(mediaIcon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              // Kapsül bilgileri
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capsule.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Açılma: ${dateFormatter.format(capsule.openingDate)}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Kalan gün
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$daysRemaining gün',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
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
