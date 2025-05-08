import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';

/// Card size enumeration for different usage contexts
enum CapsuleCardSize {
  /// Smaller size for list displays
  small,

  /// Standard size for featured displays
  standard,

  /// Larger size for detailed views
  large
}

class CapsuleCard extends StatelessWidget {
  final String senderName;
  final String imageUrl;
  final Widget? timerWidget;
  final bool isReadyToOpen;
  final AnimatedMeshGradientController controller;
  final Duration? remainingTime;
  final CapsuleCardSize cardSize;

  const CapsuleCard({
    required this.senderName,
    required this.imageUrl,
    required this.controller,
    this.isReadyToOpen = false,
    this.timerWidget,
    this.remainingTime,
    this.cardSize = CapsuleCardSize.standard,
    super.key,
  }) : assert(
          (timerWidget != null) || (remainingTime != null) || isReadyToOpen,
          'Either provide a custom timerWidget, remainingTime, or set isReadyToOpen to true',
        );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Card height calculation based on card size
    final double cardHeight;
    final double imageSize;
    final double senderImageRadius;
    final double timerScale;
    final double borderRadius;

    switch (cardSize) {
      case CapsuleCardSize.small:
        cardHeight = screenSize.height * 0.22;
        imageSize = 1;
        senderImageRadius = 16;
        timerScale = 0.8;
        borderRadius = 10;
        break;
      case CapsuleCardSize.large:
        cardHeight = screenSize.height * 0.32;
        imageSize = 1.2;
        senderImageRadius = 24;
        timerScale = 1.2;
        borderRadius = 14;
        break;
      case CapsuleCardSize.standard:
      default:
        cardHeight = screenSize.height * 0.28;
        imageSize = 1.0;
        senderImageRadius = 20;
        timerScale = 1.0;
        borderRadius = 12;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: cardSize == CapsuleCardSize.large ? 210 : 190,
        maxHeight: cardHeight,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF262742),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Stack(
          children: [
            // Gradient background when ready to open
            if (isReadyToOpen)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
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
                  padding: EdgeInsets.all(
                      cardSize == CapsuleCardSize.small ? 8 : 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: senderImageRadius,
                        backgroundImage: NetworkImage(imageUrl),
                        onBackgroundImageError: (_, __) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                      SizedBox(
                          width: cardSize == CapsuleCardSize.small ? 8 : 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.tr('Sender', args: {}),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize:
                                    cardSize == CapsuleCardSize.small ? 10 : 12,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 2),
                            AutoSizeText(
                              senderName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: cardSize == CapsuleCardSize.small
                                    ? 12
                                    : null,
                              ),
                              minFontSize: 8,
                              maxFontSize:
                                  cardSize == CapsuleCardSize.large ? 18 : 14,
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
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Transform.scale(
                            scale: imageSize,
                            child: Image.asset(
                              isReadyToOpen
                                  ? 'assets/icons/kapsul_without_bg.png'
                                  : 'assets/images/kilitkapsul.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      // Timer widget (when not ready to open)
                      if (!isReadyToOpen)
                        Center(
                          child: Transform.scale(
                            scale: timerScale,
                            child: timerWidget ??
                                CapsuleTimer(
                                  remainingTime: remainingTime!,
                                  fontSize: cardSize == CapsuleCardSize.small
                                      ? 14
                                      : 18,
                                ),
                          ),
                        ),
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

class CapsuleTimer extends StatelessWidget {
  final Duration remainingTime;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const CapsuleTimer({
    required this.remainingTime,
    this.textColor = Colors.white,
    this.fontSize = 18.0,
    this.fontWeight = FontWeight.w700,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hours = remainingTime.inHours;
    final minutes = remainingTime.inMinutes.remainder(60);
    final seconds = remainingTime.inSeconds.remainder(60);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF000000).withOpacity(0.4),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: 0.4,
          fontFamily: 'Urbanist',
        ),
      ),
    );
  }
}
