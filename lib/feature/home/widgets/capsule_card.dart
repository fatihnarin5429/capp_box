import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:capp_box/product/constants/color_cons.dart';

class CapsuleCard extends StatelessWidget {
  final String senderName;
  final String imageUrl;
  final Widget timerWidget;
  final bool isReadyToOpen;
  final AnimatedMeshGradientController controller;

  const CapsuleCard({
    required this.senderName,
    required this.imageUrl,
    required this.timerWidget,
    required this.controller,
    this.isReadyToOpen = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      decoration: BoxDecoration(
        color: const Color(0xFF262742),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Stack(
        children: [
          if (isReadyToOpen)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AnimatedMeshGradient(
                  colors: [
                    ColorConst.backgroundColor.withOpacity(1),
                    ColorConst.backgroundDark1.withOpacity(0.5),
                    ColorConst.backgroundPurple1.withOpacity(0.5),
                    ColorConst.backgroundPurple2.withOpacity(0.5),
                  ],
                  options: AnimatedMeshGradientOptions(
                    speed: 2,
                    frequency: 10,
                  ),
                  controller: controller,
                ),
              ),
            ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(imageUrl),
                      onBackgroundImageError: (_, __) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gönderen',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 12,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          AutoSizeText(
                            senderName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                            minFontSize: 10,
                            maxFontSize: 15,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Image.asset(
                      isReadyToOpen
                          ? 'assets/icons/kapsul_without_bg.png'
                          : 'assets/images/kilitkapsul.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (!isReadyToOpen) timerWidget,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
