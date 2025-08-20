import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/helpers/localization_helper.dart';
import '../../../utils/extensions/context_extensions.dart';

/// A widget that displays a dropdown or list for selecting the app language
class LanguageSelectorWidget extends ConsumerWidget {
  final bool showAsDropdown;
  final bool showCurrentLanguageOnly;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Function(Locale)? onLanguageChanged;

  const LanguageSelectorWidget({
    super.key,
    this.showAsDropdown = true,
    this.showCurrentLanguageOnly = false,
    this.padding,
    this.textStyle,
    this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);
    final localeNotifier = ref.read(currentLocaleProvider.notifier);

    if (showCurrentLanguageOnly) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          LocalizationHelper.getLocaleDisplayName(currentLocale),
          style: textStyle ?? context.textTheme.bodyMedium,
        ),
      );
    }

    if (showAsDropdown) {
      return Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Locale>(
            value: currentLocale,
            isDense: true,
            icon: Icon(
              Icons.arrow_drop_down,
              color: context.colorScheme.onSurface,
            ),
            style: textStyle ?? context.textTheme.bodyMedium,
            items: LocalizationHelper.supportedLocales
                .map((locale) => DropdownMenuItem<Locale>(
                      value: locale,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildFlag(locale),
                          const SizedBox(width: 8),
                          Text(LocalizationHelper.getLocaleDisplayName(locale)),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: (Locale? newLocale) {
              if (newLocale != null && newLocale != currentLocale) {
                localeNotifier.setLocale(newLocale);
                onLanguageChanged?.call(newLocale);
                
                // Show feedback message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Language changed to ${LocalizationHelper.getLocaleDisplayName(newLocale)}',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ),
      );
    }

    // Show as list tiles
    return Column(
      children: LocalizationHelper.supportedLocales
          .map((locale) => ListTile(
                dense: true,
                contentPadding: padding,
                leading: _buildFlag(locale),
                title: Text(
                  LocalizationHelper.getLocaleDisplayName(locale),
                  style: textStyle,
                ),
                subtitle: Text(
                  LocalizationHelper.getLocaleDisplayNameInEnglish(locale),
                  style: context.textTheme.bodySmall,
                ),
                trailing: currentLocale == locale
                    ? Icon(
                        Icons.check_circle,
                        color: context.colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  if (locale != currentLocale) {
                    localeNotifier.setLocale(locale);
                    onLanguageChanged?.call(locale);
                    
                    // Show feedback message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Language changed to ${LocalizationHelper.getLocaleDisplayName(locale)}',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ))
          .toList(),
    );
  }

  /// Build flag emoji or icon based on locale
  Widget _buildFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return const Text('🇺🇸', style: TextStyle(fontSize: 20));
      case 'id':
        return const Text('🇮🇩', style: TextStyle(fontSize: 20));
      default:
        return Icon(
          Icons.language,
          size: 20,
          color: Colors.grey[600],
        );
    }
  }
}

/// A simplified language toggle button for quick switching between languages
class LanguageToggleButton extends ConsumerWidget {
  final bool showText;
  final IconData? icon;
  final EdgeInsets? padding;

  const LanguageToggleButton({
    super.key,
    this.showText = true,
    this.icon,
    this.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);
    final localeNotifier = ref.read(currentLocaleProvider.notifier);

    final nextLocale = _getNextLocale(currentLocale);

    return InkWell(
      onTap: () {
        localeNotifier.setLocale(nextLocale);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.l10n.language + ': ${LocalizationHelper.getLocaleDisplayName(nextLocale)}',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: padding ?? const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.translate,
              color: context.colorScheme.onSurface,
            ),
            if (showText) ...[
              const SizedBox(width: 8),
              Text(
                LocalizationHelper.getLocaleDisplayName(currentLocale),
                style: context.textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Locale _getNextLocale(Locale currentLocale) {
    final currentIndex = LocalizationHelper.supportedLocales.indexOf(currentLocale);
    final nextIndex = (currentIndex + 1) % LocalizationHelper.supportedLocales.length;
    return LocalizationHelper.supportedLocales[nextIndex];
  }
}

/// A dialog for selecting language
class LanguageSelectionDialog extends ConsumerWidget {
  const LanguageSelectionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(context.l10n.language),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      content: SizedBox(
        width: double.minPositive,
        child: LanguageSelectorWidget(
          showAsDropdown: false,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          onLanguageChanged: (_) {
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.cancel),
        ),
      ],
    );
  }

  /// Show the language selection dialog
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => const LanguageSelectionDialog(),
    );
  }
}