import 'package:flutter/material.dart';
import 'package:capp_box/core/l10n/languages/en.dart';
import 'package:capp_box/core/l10n/languages/tr.dart';
import 'package:capp_box/core/l10n/languages/de.dart';
import 'package:capp_box/core/l10n/languages/it.dart';
import 'package:capp_box/core/l10n/languages/pt.dart';
import 'package:capp_box/core/l10n/languages/hi.dart';
import 'package:capp_box/core/l10n/languages/zh.dart';
import 'package:capp_box/core/l10n/languages/ru.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Static member to have access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Map containing all the translated strings
  late Map<String, String> _localizedStrings;

  // Load the language strings based on locale
  Future<bool> load() async {
    switch (locale.languageCode) {
      case 'tr':
        _localizedStrings = tr;
        break;
      case 'de':
        _localizedStrings = de;
        break;
      case 'it':
        _localizedStrings = it;
        break;
      case 'pt':
        _localizedStrings = pt;
        break;
      case 'hi':
        _localizedStrings = hi;
        break;
      case 'zh':
        _localizedStrings = zh;
        break;
      case 'ru':
        _localizedStrings = ru;
        break;
      default:
        _localizedStrings = en;
    }
    return true;
  }

  // Translate method to get the correct string based on the key
  String translate(String key, {Map<String, dynamic>? args}) {
    String text = _localizedStrings[key] ?? key;

    if (args != null) {
      args.forEach((argKey, argValue) {
        text = text.replaceAll('{$argKey}', argValue.toString());
      });
    }

    return text;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr', 'de', 'it', 'pt', 'hi', 'zh', 'ru']
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
