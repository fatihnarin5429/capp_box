import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const ProfileListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 337,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: ShapeDecoration(
            color: const Color(0xFF24223D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                leadingIcon,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const Spacer(),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.5,
                  ),
                ),
              const SizedBox(width: 12),
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
}
