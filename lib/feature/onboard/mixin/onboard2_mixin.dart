import 'package:capp_box/feature/home/view/home_page.dart';
import 'package:capp_box/feature/home/view/home_view.dart';
import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:capp_box/feature/login/view/login_view.dart';
import 'package:capp_box/feature/login/view/phone_login_view.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';

mixin Onboard2Mixin<T extends StatefulWidget> on State<T> {
  bool isLoading = false;
  int? selectedButtonIndex;
  bool isCapsuleActive = false;

  Widget buildAuthButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildOutlinedButton(
          onPressed: () {
            setState(() {
              selectedButtonIndex = 0;
            });
            // Apple sign in logic will be added here
          },
          icon: SvgPicture.asset(
            'assets/icons/apple.svg',
            // colorFilter: ColorFilter.mode(
            //   selectedButtonIndex == 0
            //       ? const Color(0xFFE5E5E5)
            //       : const Color(0xFF84858E),
            //   BlendMode.srcIn,
            // ),
          ),
          label: context.tr('connect_with_apple', args: {}),
          isSelected: selectedButtonIndex == 0,
        ),
        const SizedBox(height: 12),
        buildOutlinedButton(
          onPressed: () {
            setState(() {
              selectedButtonIndex = 1;
            });
          },
          icon: SvgPicture.asset(
            'assets/icons/google.svg',
            // colorFilter: ColorFilter.mode(
            //   selectedButtonIndex == 1
            //       ? const Color(0xFFE5E5E5)
            //       : const Color(0xFF84858E),
            //   BlendMode.srcIn,
            // ),
          ),
          label: context.tr('google', args: {}),
          isSelected: selectedButtonIndex == 1,
        ),
        const SizedBox(height: 12),
        buildOutlinedButton(
          onPressed: () {
            setState(() {
              selectedButtonIndex = 2;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          },
          icon: SvgPicture.asset(
            'assets/icons/mail.svg',
            // colorFilter: ColorFilter.mode(
            //   selectedButtonIndex == 2
            //       ? const Color(0xFFE5E5E5)
            //       : const Color(0xFF84858E),
            //   BlendMode.srcIn,
            // ),
          ),
          label: context.tr('continue_with_email', args: {}),
          isSelected: selectedButtonIndex == 2,
        ),
        const SizedBox(height: 12),
        buildOutlinedButton(
          onPressed: () {
            setState(() {
              selectedButtonIndex = 3;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PhoneLoginView()),
            );
          },
          icon: const Icon(Icons.phone, color: Colors.white),
          label: context.tr('continue_with_phone', args: {}),
          isSelected: selectedButtonIndex == 3,
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            if (isCapsuleActive) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          },
          child: Text(
            context.tr('continue_without_account', args: {}),
            style: const TextStyle(
              color: Color(0xFF84858E),
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGradientButton({
    required VoidCallback onPressed,
    required Widget icon,
    required String label,
    bool isSelected = false,
  }) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: isSelected
              ? [const Color(0xFFB224EF), const Color(0xFF7579FF)]
              : [const Color(0xFF1C1D31), const Color(0xFF1C1D31)],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              color: isSelected ? Colors.transparent : const Color(0xFFB2B2B2)),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 24,
                child: Center(child: icon),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFFE5E5E5)
                      : const Color(0xFF84858E),
                  fontSize: 14,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOutlinedButton({
    required Widget icon,
    required String label,
    required VoidCallback onPressed,
    bool isSelected = false,
  }) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: isSelected
              ? [const Color(0xFFB224EF), const Color(0xFF7579FF)]
              : [const Color(0xFF1C1D31), const Color(0xFF1C1D31)],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              color: isSelected ? Colors.transparent : const Color(0xFFB2B2B2)),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Center(child: icon),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 150,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFFE5E5E5)
                        : const Color(0xFF84858E),
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
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
