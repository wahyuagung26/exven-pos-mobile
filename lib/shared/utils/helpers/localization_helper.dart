import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n/generated/app_localizations.dart';

/// Helper class for localization functionality
/// Provides easy access to translations, locale management, and formatting
class LocalizationHelper {
  static const String _localeKey = 'app_locale';
  
  /// Supported locales in the application
  static const List<Locale> supportedLocales = [
    Locale('en', ''), // English
    Locale('id', ''), // Indonesian
  ];
  
  /// Default locale (English)
  static const Locale defaultLocale = Locale('en', '');
  
  /// Get localization instance from context
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
  
  /// Get current locale from SharedPreferences
  static Future<Locale> getCurrentLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString(_localeKey);
    
    if (localeCode != null && localeCode.isNotEmpty) {
      return Locale(localeCode);
    }
    
    // Check system locale
    final systemLocale = PlatformDispatcher.instance.locale;
    if (isLocaleSupported(systemLocale)) {
      return systemLocale;
    }
    
    return defaultLocale;
  }
  
  /// Save locale to SharedPreferences
  static Future<bool> setLocale(Locale locale) async {
    if (!isLocaleSupported(locale)) {
      return false;
    }
    
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_localeKey, locale.languageCode);
  }
  
  /// Check if locale is supported
  static bool isLocaleSupported(Locale locale) {
    return supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }
  
  /// Get locale display name in the locale's language
  static String getLocaleDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'id':
        return 'Bahasa Indonesia';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
  
  /// Get locale display name in English
  static String getLocaleDisplayNameInEnglish(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'id':
        return 'Indonesian';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
  
  /// Format currency based on locale
  static String formatCurrency(double amount, Locale locale) {
    switch (locale.languageCode) {
      case 'id':
        return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
      case 'en':
      default:
        return '\$${amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
    }
  }
  
  /// Format number based on locale
  static String formatNumber(num number, Locale locale) {
    switch (locale.languageCode) {
      case 'id':
        return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
      case 'en':
      default:
        return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    }
  }
  
  /// Format date based on locale
  static String formatDate(DateTime date, Locale locale) {
    switch (locale.languageCode) {
      case 'id':
        return '${date.day}/${date.month}/${date.year}';
      case 'en':
      default:
        return '${date.month}/${date.day}/${date.year}';
    }
  }
  
  /// Format time based on locale
  static String formatTime(DateTime time, Locale locale) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
  
  /// Format datetime based on locale
  static String formatDateTime(DateTime dateTime, Locale locale) {
    return '${formatDate(dateTime, locale)} ${formatTime(dateTime, locale)}';
  }
  
  /// Get error message with fallback
  static String getErrorMessage(
    BuildContext context,
    String errorKey, [
    String? fallback,
  ]) {
    try {
      final localizations = of(context);
      switch (errorKey) {
        case 'network_error':
          return localizations.networkError;
        case 'server_error':
          return localizations.serverError;
        case 'unauthorized_access':
          return localizations.unauthorizedAccess;
        case 'forbidden':
          return localizations.forbidden;
        case 'not_found':
          return localizations.notFound;
        case 'validation_error':
          return localizations.validationError;
        default:
          return fallback ?? localizations.error;
      }
    } catch (e) {
      return fallback ?? 'An error occurred';
    }
  }
  
  /// Get validation message
  static String getValidationMessage(
    BuildContext context,
    String validationType, [
    Map<String, dynamic>? params,
  ]) {
    try {
      final localizations = of(context);
      switch (validationType) {
        case 'required':
          return localizations.requiredField;
        case 'invalid_email':
          return localizations.invalidEmail;
        case 'invalid_password':
          return localizations.invalidPassword;
        case 'invalid_format':
          return localizations.invalidFormat;
        case 'field_too_short':
          return localizations.fieldTooShort;
        case 'field_too_long':
          return localizations.fieldTooLong;
        case 'password_requirements':
          return localizations.passwordRequirements;
        default:
          return localizations.validationError;
      }
    } catch (e) {
      return 'Validation error';
    }
  }
  
  /// Get success message
  static String getSuccessMessage(
    BuildContext context,
    String successKey, [
    String? fallback,
  ]) {
    try {
      final localizations = of(context);
      switch (successKey) {
        case 'login_success':
          return localizations.loginSuccess;
        case 'form_saved':
          return localizations.formSaved;
        case 'product_saved':
          return localizations.productSaved;
        case 'product_deleted':
          return localizations.productDeleted;
        default:
          return fallback ?? localizations.success;
      }
    } catch (e) {
      return fallback ?? 'Success';
    }
  }
  
  /// Determine if the current locale is RTL
  static bool isRTL(Locale locale) {
    // Indonesian and English are LTR languages
    // Add RTL languages here if needed in the future
    return false;
  }
  
  /// Get plural form (basic implementation)
  /// For more complex plural rules, consider using intl package's plural rules
  static String getPlural(
    BuildContext context,
    String singularKey,
    String pluralKey,
    int count,
  ) {
    return count == 1 ? singularKey : pluralKey;
  }
}

/// Riverpod provider for current locale
final currentLocaleProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

/// State notifier for managing locale changes
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(LocalizationHelper.defaultLocale) {
    _loadLocale();
  }
  
  /// Load saved locale from SharedPreferences
  Future<void> _loadLocale() async {
    final savedLocale = await LocalizationHelper.getCurrentLocale();
    state = savedLocale;
  }
  
  /// Set new locale and save it
  Future<void> setLocale(Locale locale) async {
    if (LocalizationHelper.isLocaleSupported(locale)) {
      final success = await LocalizationHelper.setLocale(locale);
      if (success) {
        state = locale;
      }
    }
  }
  
  /// Reset to system locale or default
  Future<void> resetToSystemLocale() async {
    final systemLocale = PlatformDispatcher.instance.locale;
    if (LocalizationHelper.isLocaleSupported(systemLocale)) {
      await setLocale(systemLocale);
    } else {
      await setLocale(LocalizationHelper.defaultLocale);
    }
  }
}

/// Extension on BuildContext for easy localization access
extension LocalizationExtension on BuildContext {
  /// Get AppLocalizations instance
  AppLocalizations get l10n => LocalizationHelper.of(this);
  
  /// Get current locale
  Locale get locale => Localizations.localeOf(this);
  
  /// Format currency for current locale
  String formatCurrency(double amount) =>
      LocalizationHelper.formatCurrency(amount, locale);
  
  /// Format number for current locale
  String formatNumber(num number) =>
      LocalizationHelper.formatNumber(number, locale);
  
  /// Format date for current locale
  String formatDate(DateTime date) =>
      LocalizationHelper.formatDate(date, locale);
  
  /// Format time for current locale
  String formatTime(DateTime time) =>
      LocalizationHelper.formatTime(time, locale);
  
  /// Format datetime for current locale
  String formatDateTime(DateTime dateTime) =>
      LocalizationHelper.formatDateTime(dateTime, locale);
      
  /// Get error message with context
  String getErrorMessage(String errorKey, [String? fallback]) =>
      LocalizationHelper.getErrorMessage(this, errorKey, fallback);
      
  /// Get validation message with context
  String getValidationMessage(
    String validationType, [
    Map<String, dynamic>? params,
  ]) =>
      LocalizationHelper.getValidationMessage(this, validationType, params);
      
  /// Get success message with context
  String getSuccessMessage(String successKey, [String? fallback]) =>
      LocalizationHelper.getSuccessMessage(this, successKey, fallback);
}