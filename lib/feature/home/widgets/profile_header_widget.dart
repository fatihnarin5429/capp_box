import 'package:flutter/material.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';

/// A widget that displays the user's profile information in the header section of the home screen.
class ProfileHeaderWidget extends StatelessWidget {
  final String username;
  final String? profileImageUrl;

  const ProfileHeaderWidget({
    super.key,
    required this.username,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/icons/menu.png', color: Colors.white),
            ),
            const SizedBox(width: 24),
            _buildProfileImage(),
            const SizedBox(width: 10),
            _buildUserInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 40,
      height: 40,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child:
          profileImageUrl != null
              ? Image.network(
                profileImageUrl!,
                fit: BoxFit.fill,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.person, color: Colors.grey, size: 30),
              )
              : const Icon(Icons.person, color: Colors.grey, size: 30),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('hello', args: {}),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          username,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
