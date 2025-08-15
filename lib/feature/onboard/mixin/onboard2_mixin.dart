import 'package:capp_box/core/service/auth_service.dart';
import 'package:capp_box/feature/home/view/home_page.dart';
import 'package:capp_box/feature/login/view/login_view.dart';
import 'package:capp_box/feature/login/view/phone_login_view.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

mixin Onboard2Mixin<T extends StatefulWidget> on State<T> {
  // --- State ---
  bool isLoading = false;
  int? _selected; // 0: Apple, 1: Google, 2: Email, 3: Phone
  bool isCapsuleActive = false;

  final AuthService _auth = AuthService();

  // --- UI Constants ---
  static const _hGap = SizedBox(height: 12);
  static const _radius = 100.0;
  static const _btnHeight = 48.0;
  static const _gradActive = [Color(0xFFB224EF), Color(0xFF7579FF)];
  static const _gradIdle = [Color(0xFF1C1D31), Color(0xFF1C1D31)];

  // --- Public builder ---
  Widget buildAuthButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _AuthButton(
          label: 'Apple ile bağlan',
          icon: SvgPicture.asset('assets/icons/apple.svg'),
          selected: _selected == 0,
          loading: isLoading && _selected == 0,
          onTap: () => _handleAppleSignIn(),
        ),
        _hGap,
        _AuthButton(
          label: 'Google ile bağlan',
          icon: SvgPicture.asset('assets/icons/google.svg'),
          selected: _selected == 1,
          loading: isLoading && _selected == 1,
          onTap: () => _handleGoogleSignIn(),
        ),
        _hGap,
        _AuthButton(
          label: context.tr('continue_with_email', args: {}),
          icon: SvgPicture.asset('assets/icons/mail.svg'),
          selected: _selected == 2,
          onTap: () {
            setState(() => _selected = 2);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginView()),
            );
          },
        ),
        _hGap,
        _AuthButton(
          label: context.tr('continue_with_phone', args: {}),
          icon: const Icon(Icons.phone, color: Colors.white, size: 20),
          selected: _selected == 3,
          onTap: () {
            setState(() => _selected = 3);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PhoneLoginView()),
            );
          },
        ),
        _hGap,
        TextButton(
          onPressed:
              isLoading
                  ? null
                  : () {
                    final page = const HomePage();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => page),
                    );
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

  // --- Handlers ---
  Future<void> _handleAppleSignIn() async {
    if (isLoading) return;
    setState(() {
      _selected = 0;
      isLoading = true;
    });

    final result = await _auth.signInWithApple();
    if (!mounted) return;

    if (result.isSuccess) {
      _goHome();
    } else {
      _showErr(result.message ?? 'Apple ile giriş başarısız.');
    }

    if (mounted) setState(() => isLoading = false);
  }

  Future<void> _handleGoogleSignIn() async {
    print('Google ile giriş başlatıldı');
    if (isLoading) return;
    setState(() {
      _selected = 1;
      isLoading = true;
    });
    try {
      final result = await _auth.signInWithGoogle();
      if (!mounted) return;

      if (result.isSuccess) {
        print('Google ile giriş başarılı');
        _goHome();
      } else {
        _showErr(result.message ?? 'Google ile giriş başarısız.');
      }
    } catch (e) {
      print('Google ile giriş hatası: $e');
    }
    if (!mounted) return;

    // if (result.isSuccess) {
    //   print('Google ile giriş başarılı');
    //   _goHome();
    // } else {
    //   _showErr(result.message ?? 'Google ile giriş başarısız.');
    // }

    if (mounted) setState(() => isLoading = false);
  }

  // --- Helpers ---
  void _goHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  void _showErr(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

/// Tek tip buton görünümü – gradient/çerçeve/disable/loader burada kontrol edilir.
class _AuthButton extends StatelessWidget {
  const _AuthButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.loading = false,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final bool loading;

  static const _btnHeight = Onboard2Mixin._btnHeight;
  static const _radius = Onboard2Mixin._radius;
  static const _gradActive = Onboard2Mixin._gradActive;
  static const _gradIdle = Onboard2Mixin._gradIdle;

  @override
  Widget build(BuildContext context) {
    final disabled = loading;
    return Opacity(
      opacity: disabled ? 0.8 : 1,
      child: Container(
        width: double.infinity,
        height: _btnHeight,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: selected ? _gradActive : _gradIdle,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: selected ? Colors.transparent : const Color(0xFFB2B2B2),
            ),
            borderRadius: BorderRadius.circular(_radius),
          ),
        ),
        child: MaterialButton(
          onPressed: disabled ? null : onTap,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 24, height: 24, child: Center(child: icon)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color:
                        selected
                            ? const Color(0xFFE5E5E5)
                            : const Color(0xFF84858E),
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (loading) ...[
                const SizedBox(width: 10),
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
