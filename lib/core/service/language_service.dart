import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static final LanguageService _instance = LanguageService._internal();

  factory LanguageService() => _instance;

  LanguageService._internal();

  final String _languageCodeKey = 'languageCode';
  Locale? _currentLocale;
  final StreamController<Locale> _localeController =
      StreamController<Locale>.broadcast();

  // Supported locales
  final List<Locale> supportedLocales = const [
    Locale('en'), // English
    Locale('tr'), // Turkish
    Locale('de'), // German
    Locale('it'), // Italian
    Locale('pt'), // Portuguese
    Locale('ru'), // Russian
  ];

  // Get current locale
  Locale get currentLocale => _currentLocale ?? const Locale('en');

  // Initialize the language service
  Future<void> init() async {
    await setLanguage();
  }

  // Set language based on device locale or saved preference
  Future<void> setLanguage() async {
    Locale deviceLocale = PlatformDispatcher.instance.locale;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(_languageCodeKey) == null) {
      // Check if device language is supported
      String deviceLanguage = deviceLocale.languageCode;
      if (supportedLocales.any(
        (locale) => locale.languageCode == deviceLanguage,
      )) {
        await setLocale(Locale(deviceLanguage));
      } else {
        // If device language is not supported, set English as default
        await setLocale(const Locale('en'));
      }
    } else {
      await setLocale(Locale(prefs.getString(_languageCodeKey)!));
    }
  }

  // Set locale and save to preferences
  Future<void> setLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, locale.languageCode);
    _currentLocale = locale;

    // Notify listeners about locale change
    _localeController.add(locale);
  }

  // Get stream for locale changes
  Stream<Locale> get localeStream => _localeController.stream;

  // Dispose the stream controller
  void dispose() {
    _localeController.close();
  }

  // Get saved language code
  Future<String?> getSavedLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageCodeKey);
  }
}
