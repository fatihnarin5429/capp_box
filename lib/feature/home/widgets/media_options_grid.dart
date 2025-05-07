import 'package:flutter/material.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/view/create_capsul_view.dart';

/// A widget that displays the grid of media type options for creating new capsules.
class MediaOptionsGrid extends StatelessWidget {
  const MediaOptionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Çeviri kontrolü için debug bilgisi
    final translatedText = context.tr('Write');
    final translatedVideo = context.tr('Video');
    final translatedVoice = context.tr('Voice');
    final translatedPhoto = context.tr('Photo');
    final translatedFree = context.tr('Free');
    final translatedPremium = context.tr('premium_feature_indicator');

    print(translatedText);
    print(translatedVideo);
    print(translatedVoice);
    print(translatedPhoto);
    print(translatedFree);
    print(translatedPremium);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kapsül oluşturma başlığı
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              context.tr('What_to_create_today'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Media options grid
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOptionCard(
                    iconColor: const Color(0xFF4052EE),
                    context: context,
                    icon: 'assets/icons/write.png',
                    title: context.tr('Write'),
                    isPremium: false,
                    onTap: () => _navigateToCreateCapsule(context),
                  ),
                  _buildOptionCard(
                    iconColor: const Color(0xFFD93B3B),
                    context: context,
                    icon: 'assets/icons/video.png',
                    title: context.tr('Video'),
                    isPremium: true,
                    onTap: () => _navigateToCreateCapsule(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildOptionCard(
                    context: context,
                    icon: 'assets/icons/ses.png',
                    iconColor: const Color(0xFF58D65A),
                    title: context.tr('Voice'),
                    isPremium: true,
                    onTap: () => _navigateToCreateCapsule(context),
                  ),
                  _buildOptionCard(
                    context: context,
                    icon: 'assets/icons/galeri.png',
                    iconColor: const Color(0xFF9747FF),
                    title: context.tr('Photo'),
                    isPremium: true,
                    onTap: () => _navigateToCreateCapsule(context),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToCreateCapsule(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateCapsulView(),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required String icon,
    required String title,
    required bool isPremium,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    // Fiyat anahtarlarını belirle
    String priceKey = 'price_text_capsule'; // Varsayılan olarak ücretsiz

    if (title == context.tr('Write')) {
      priceKey = 'price_text_capsule';
      print(priceKey);
    } else if (title == context.tr('Video')) {
      priceKey = 'price_video_capsule';
      print(priceKey);
    } else if (title == context.tr('Voice')) {
      priceKey = 'price_audio_capsule';
      print(priceKey);
    } else if (title == context.tr('Photo')) {
      priceKey = 'price_photo_capsule';
      print(priceKey);
    }

    final String priceText = context.tr(priceKey);

    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.43,
        height: 140,
        decoration: BoxDecoration(
          color: const Color(0xFF262741),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    icon,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    isPremium
                        ? context.tr('Premium', args: {})
                        : context.tr('Free', args: {}),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    priceText,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
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

  Color _getColorForMediaType(String title) {
    if (title == 'Text' || title == 'Yazı') {
      return const Color(0xFF4052EE);
    } else if (title == 'Video') {
      return const Color(0xFFD93B3B);
    } else if (title == 'Audio' || title == 'Ses') {
      return const Color(0xFF58D65A);
    } else {
      return const Color(0xFF9747FF); // For Photo/Fotoğraf
    }
  }
}
