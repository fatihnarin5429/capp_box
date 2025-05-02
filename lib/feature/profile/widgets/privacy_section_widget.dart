import 'package:capp_box/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/package/widgets/profile_widgets.dart';
import 'package:capp_box/feature/profile/view/gizlilik_view.dart';
import 'package:capp_box/feature/profile/view/help_View.dart';

class PrivacySectionWidget extends StatelessWidget {
  const PrivacySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            localizations.translate('privacy_security'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileListTile(
                leadingIcon: 'assets/images/secure.png',
                title: localizations.translate('privacy'),
                subtitle: localizations.translate('privacy'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const GizlilikView())),
              ),
              ProfileListTile(
                leadingIcon: 'assets/images/help.png',
                title: localizations.translate('help'),
                subtitle: localizations.translate('help'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HelpView())),
              ),
              ProfileListTile(
                isLanguage: true,
                leadingIcon: 'assets/icons/language.png',
                title: localizations.translate('language'),
                subtitle: localizations.translate('language_settings'),
                onTap: () => Navigator.pushNamed(context, '/language_settings'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
