import 'package:bot_toast/bot_toast.dart';
import 'package:capp_box/core/l10n/app_localizations.dart';
import 'package:capp_box/core/service/language_service.dart';
import 'package:capp_box/main.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

class LanguageSettingsView extends StatefulWidget {
  const LanguageSettingsView({super.key});

  @override
  State<LanguageSettingsView> createState() => _LanguageSettingsViewState();
}

class _LanguageSettingsViewState extends State<LanguageSettingsView> {
  String _currentLanguageCode = 'en';
  final LanguageService _languageService = LanguageService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final languageCode = await _languageService.getSavedLanguageCode();
    if (mounted) {
      setState(() {
        _currentLanguageCode = languageCode ?? 'en';
        _isLoading = false;
      });
    }
  }

  Future<void> _changeLanguage(String languageCode) async {
    final currentContext = context;
    final locale = Locale(languageCode);
    await _languageService.setLocale(locale);

    setState(() {
      _currentLanguageCode = languageCode;
    });

    // Update app locale
    if (currentContext.mounted) {
      final state = currentContext.findAncestorStateOfType<MyAppState>();
      if (state != null) {
        state.setLocale(locale);

        // Show success message
        BotToast.showText(
          text:
              AppLocalizations.of(currentContext).translate('language_changed'),
          duration: const Duration(seconds: 2),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorConst.topLeftPurple2,
                  ColorConst.topLeftPurple1,
                  ColorConst.topLeftPurple1,
                  ColorConst.backgroundDark1,
                ],
                stops: [
                  0.03,
                  0.3,
                  0.19,
                  0.89,
                ],
              ),
            ),
          ),
          title: Text(
            localizations.translate('language_settings'),
            style: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: const Stack(
          children: [
            BackgroundGradient(),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  'Loading...',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorConst.topLeftPurple2,
                ColorConst.topLeftPurple1,
                ColorConst.topLeftPurple1,
                ColorConst.backgroundDark1,
              ],
              stops: [
                0.03,
                0.3,
                0.19,
                0.89,
              ],
            ),
          ),
        ),
        title: Text(
          localizations.translate('language_settings'),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          const BackgroundGradient(),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.translate('language'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildLanguageOption(
                  context,
                  'English',
                  localizations.translate('english'),
                  'en',
                ),
                const SizedBox(height: 16),
                _buildLanguageOption(
                  context,
                  'Türkçe',
                  localizations.translate('turkish'),
                  'tr',
                ),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConst.gradientMiddle2,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      localizations.translate('ok'),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String title,
      String subtitle, String languageCode) {
    final isSelected = _currentLanguageCode == languageCode;
    final localizations = AppLocalizations.of(context);

    return InkWell(
      onTap: () => _changeLanguage(languageCode),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: ColorConst.topLeftPurple1, width: 1)
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languageCode == 'en'
                        ? localizations.translate('english')
                        : localizations.translate('turkish'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: languageCode,
              groupValue: _currentLanguageCode,
              fillColor: MaterialStateProperty.all(Colors.white),
              onChanged: (value) {
                if (value != null) {
                  _changeLanguage(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
