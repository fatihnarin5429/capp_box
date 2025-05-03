import 'package:capp_box/core/l10n/app_localizations.dart';
import 'package:capp_box/core/l10n/localization_helper.dart';
import 'package:flutter/material.dart';

/// BuildContext üzerine yerelleştirme fonksiyonları ekleme
extension LocalizationExtension on BuildContext {
  /// Geçerli yerelleştirmeyi alma
  AppLocalizations get loc => AppLocalizations.of(this);

  /// Metin çevirisi için kısa yol
  String tr(String key, {Map<String, dynamic>? args}) =>
      loc.translate(key, args: args);

  /// Geçerli locale'i alma
  Locale get currentLocale => Localizations.localeOf(this);

  /// Tarih formatı
  String formatDate(DateTime date) =>
      LocalizationHelper.formatDate(date, currentLocale);

  /// Tarih-saat formatı
  String formatDateTime(DateTime dateTime) =>
      LocalizationHelper.formatDateTime(dateTime, currentLocale);

  /// Saat formatı
  String formatTime(DateTime time) =>
      LocalizationHelper.formatTime(time, currentLocale);

  /// Para birimi formatı
  String formatCurrency(double amount) =>
      LocalizationHelper.formatCurrency(amount, currentLocale);

  /// Sayı formatı
  String formatNumber(double number) =>
      LocalizationHelper.formatNumber(number, currentLocale);

  /// Gün adı
  String getDayName(DateTime date) =>
      LocalizationHelper.getDayName(date, currentLocale);

  /// Ay adı
  String getMonthName(DateTime date) =>
      LocalizationHelper.getMonthName(date, currentLocale);
}
