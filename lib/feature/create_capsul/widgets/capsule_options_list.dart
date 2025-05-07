import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/widgets/kapsul_secenek_card.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:flutter/material.dart';

class CapsuleOptionsList extends StatelessWidget {
  final MediaType? secilenTip;
  final bool premiumOdendi;
  final Function(MediaType) onTipSecildi;

  const CapsuleOptionsList({
    super.key,
    required this.secilenTip,
    required this.premiumOdendi,
    required this.onTipSecildi,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        KapsulSecenekCard(
          icon: 'assets/icons/write.png',
          baslik: context.tr('Write', args: {}),
          isPremium: false,
          premiumOdendi: premiumOdendi,
          fiyat: context.tr('Free', args: {}),
          secilenTip: secilenTip,
          onTap: () => onTipSecildi(MediaType.text),
          tip: MediaType.text,
        ),
        KapsulSecenekCard(
          icon: 'assets/icons/video.png',
          baslik: context.tr('Video', args: {}),
          isPremium: true,
          premiumOdendi: premiumOdendi,
          fiyat: '449.99 ₺',
          secilenTip: secilenTip,
          tip: MediaType.video,
          onTap: () => onTipSecildi(MediaType.video),
        ),
        KapsulSecenekCard(
          icon: 'assets/icons/ses.png',
          baslik: context.tr('Voice', args: {}),
          isPremium: false,
          premiumOdendi: premiumOdendi,
          fiyat: '149.99 ₺',
          secilenTip: secilenTip,
          tip: MediaType.voice,
          onTap: () => onTipSecildi(MediaType.voice),
        ),
        KapsulSecenekCard(
          icon: 'assets/icons/galeri.png',
          baslik: context.tr('Photo', args: {}),
          isPremium: false,
          premiumOdendi: premiumOdendi,
          fiyat: '249.99 ₺',
          secilenTip: secilenTip,
          tip: MediaType.photo,
          onTap: () => onTipSecildi(MediaType.photo),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
