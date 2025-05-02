import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Uygulama genelinde lokalizasyon için yardımcı fonksiyonlar içeren sınıf
class LocalizationHelper {
  /// Tarihi yerelleştirme
  static String formatDate(DateTime date, Locale locale) {
    String languageCode = locale.languageCode;

    // Locale'e göre tarih formatını belirle
    if (languageCode == 'tr') {
      return DateFormat('dd.MM.yyyy', 'tr_TR').format(date);
    }

    // Varsayılan olarak İngilizce format
    return DateFormat('MM/dd/yyyy', 'en_US').format(date);
  }

  /// Tarihi ve saati yerelleştirme
  static String formatDateTime(DateTime dateTime, Locale locale) {
    String languageCode = locale.languageCode;

    if (languageCode == 'tr') {
      return DateFormat('dd.MM.yyyy HH:mm', 'tr_TR').format(dateTime);
    }

    return DateFormat('MM/dd/yyyy h:mm a', 'en_US').format(dateTime);
  }

  /// Saati yerelleştirme
  static String formatTime(DateTime time, Locale locale) {
    String languageCode = locale.languageCode;

    if (languageCode == 'tr') {
      return DateFormat('HH:mm', 'tr_TR').format(time); // 24 saat formatı
    }

    return DateFormat('h:mm a', 'en_US')
        .format(time); // 12 saat formatı (AM/PM)
  }

  /// Para birimini yerelleştirme
  static String formatCurrency(double amount, Locale locale) {
    String languageCode = locale.languageCode;

    if (languageCode == 'tr') {
      return NumberFormat.currency(
        locale: 'tr_TR',
        symbol: '₺',
        decimalDigits: 2,
      ).format(amount);
    }

    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    ).format(amount);
  }

  /// Sayıları yerelleştirme
  static String formatNumber(double number, Locale locale) {
    String languageCode = locale.languageCode;

    if (languageCode == 'tr') {
      return NumberFormat.decimalPattern('tr_TR').format(number);
    }

    return NumberFormat.decimalPattern('en_US').format(number);
  }

  /// Gün ismini yerelleştirme
  static String getDayName(DateTime date, Locale locale) {
    String languageCode = locale.languageCode;

    if (languageCode == 'tr') {
      return DateFormat('EEEE', 'tr_TR').format(date);
    }

    return DateFormat('EEEE', 'en_US').format(date);
  }

  /// Ay ismini yerelleştirme
  static String getMonthName(DateTime date, Locale locale) {
    String languageCode = locale.languageCode;

    if (languageCode == 'tr') {
      return DateFormat('MMMM', 'tr_TR').format(date);
    }

    return DateFormat('MMMM', 'en_US').format(date);
  }
}
