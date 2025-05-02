import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileListTile extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isLanguage;

  const ProfileListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isLanguage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: ShapeDecoration(
            color: const Color(0xFF24223D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Row(
            children: [
              _buildLeadingIcon(),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (subtitle != null)
                Expanded(
                  child: Text(
                    subtitle!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    if (isLanguage) {
      return const Icon(
        Icons.language,
        color: Colors.white,
        size: 24,
      );
    }

    if (leadingIcon.endsWith('.svg')) {
      return SvgPicture.asset(
        leadingIcon,
        width: 24,
        height: 24,
        color: Colors.white,
      );
    }

    return Image.asset(
      leadingIcon,
      width: 24,
      height: 24,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.image_not_supported_outlined,
          color: Colors.white,
          size: 24,
        );
      },
    );
  }
}
