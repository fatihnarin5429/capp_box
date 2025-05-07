import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';

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
    final screenSize = MediaQuery.of(context).size;
    final cardHeight =
        screenSize.height * 0.28; // Responsive height calculation

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 190,
        maxHeight: cardHeight,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF262742),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Stack(
          children: [
            // Gradient background when ready to open
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
            // Content
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sender information
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
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr('Sender', args: {}),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 2),
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
                // Capsule image and timer
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Image with fixed aspect ratio
                      AspectRatio(
                        aspectRatio: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            isReadyToOpen
                                ? 'assets/icons/kapsul_without_bg.png'
                                : 'assets/images/kilitkapsul.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Timer widget (when not ready to open)
                      if (!isReadyToOpen) timerWidget,
                    ],
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
