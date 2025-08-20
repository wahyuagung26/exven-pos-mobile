# Internationalization (i18n) Setup Guide

Complete internationalization support for Indonesian and English languages in the ExVen POS Lite Flutter application.

## Overview

This POS system supports:
- **English (en)** - Default language
- **Indonesian (id)** - Primary local language
- Persistent locale preferences
- Context-appropriate business terminology
- Indonesian currency and date formatting
- Comprehensive error and validation messages

## File Structure

```
lib/
├── l10n/
│   ├── app_en.arb                     # English translations
│   ├── app_id.arb                     # Indonesian translations  
│   ├── header.txt                     # Generation header
│   └── generated/                     # Auto-generated files
│       ├── app_localizations.dart
│       ├── app_localizations_en.dart
│       └── app_localizations_id.dart
├── shared/
│   ├── utils/helpers/
│   │   └── localization_helper.dart   # Core localization utilities
│   └── presentation/widgets/common/
│       ├── language_selector_widget.dart      # Language selection UI
│       ├── localization_demo_widget.dart      # Demo components
│       └── localization_demo_widget.dart
└── features/settings/presentation/pages/
    └── settings_page.dart             # Settings page with language selection

Configuration:
├── l10n.yaml                          # Localization configuration
└── pubspec.yaml                       # Dependencies
```

## Configuration Files

### l10n.yaml
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
output-dir: lib/l10n/generated
nullable-getter: false
synthetic-package: false
header-insertion-file: lib/l10n/header.txt
use-deferred-loading: false
preferred-supported-locales: [ en, id ]
```

### pubspec.yaml dependencies
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any
  shared_preferences: ^2.3.3

flutter:
  generate: true
```

## Translation Categories

### 1. Common/General Terms
- App name, version, loading states
- Basic actions (yes, no, cancel, confirm, save, delete)
- Navigation (next, previous, done, retry)

### 2. Authentication
- Login, logout, register
- Email, password, confirm password
- Remember me, forgot password
- Validation messages (invalid email, invalid password)
- Success/failure messages

### 3. Navigation
- Dashboard, products, customers, transactions
- Reports, settings, profile
- Home, back, menu

### 4. Forms & Validation
- Required field, invalid format
- Field length validation
- Password requirements
- Form saved/error messages

### 5. Products & Inventory
- Product name, code, price, category, stock
- Add/edit/delete product operations
- Success confirmations

### 6. Business Terms
- Customer, transaction, payment
- Discount, tax, total, subtotal
- Cash, card, transfer payment methods

### 7. Error Messages
- Network error, server error
- Unauthorized access, forbidden, not found
- Validation errors with context

### 8. POS-Specific Terms
- Analytics, sales report, inventory
- Cashier, manager, owner roles
- Outlet, tenant management

## Usage Examples

### Basic Translation Access

```dart
import 'package:flutter/material.dart';
import '../shared/utils/extensions/context_extensions.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(context.l10n.appName),           // "ExVen POS"
        Text(context.l10n.dashboard),         // "Dashboard" / "Dasbor"
        Text(context.l10n.products),          // "Products" / "Produk"
      ],
    );
  }
}
```

### Currency Formatting

```dart
// Using context extension
Text(context.formatCurrency(1234567.89))
// English: $1,234,567.89
// Indonesian: Rp 1.234.568

// Using helper directly
final formatted = LocalizationHelper.formatCurrency(
  1234567.89, 
  Locale('id')
); // "Rp 1.234.568"
```

### Date/Time Formatting

```dart
final now = DateTime.now();

// Date formatting
Text(context.formatDate(now))
// English: 8/20/2025
// Indonesian: 20/8/2025

// Time formatting  
Text(context.formatTime(now))
// Both: 14:30

// DateTime formatting
Text(context.formatDateTime(now))
// English: 8/20/2025 14:30
// Indonesian: 20/8/2025 14:30
```

### Error Handling

```dart
// Get contextual error messages
String errorMsg = context.getErrorMessage('network_error');
// English: "Network error. Please check your internet connection"
// Indonesian: "Kesalahan jaringan. Mohon periksa koneksi internet Anda"

// Validation messages
String validationMsg = context.getValidationMessage('required');
// English: "This field is required"
// Indonesian: "Kolom ini wajib diisi"
```

## Language Selection Components

### 1. Language Selector Widget

```dart
// Dropdown style
LanguageSelectorWidget(
  showAsDropdown: true,
  onLanguageChanged: (locale) {
    print('Language changed to: ${locale.languageCode}');
  },
)

// List style
LanguageSelectorWidget(
  showAsDropdown: false,
  padding: EdgeInsets.all(16),
)
```

### 2. Language Toggle Button

```dart
// Quick toggle between languages
LanguageToggleButton(
  showText: true,
  icon: Icons.translate,
)
```

### 3. Language Selection Dialog

```dart
// Show language selection dialog
ElevatedButton(
  onPressed: () => LanguageSelectionDialog.show(context),
  child: Text('Select Language'),
)
```

## State Management

The localization uses Riverpod for state management:

```dart
// Access current locale
final currentLocale = ref.watch(currentLocaleProvider);

// Change locale
final localeNotifier = ref.read(currentLocaleProvider.notifier);
await localeNotifier.setLocale(Locale('id'));

// Reset to system locale
await localeNotifier.resetToSystemLocale();
```

## Indonesian Localization Features

### Currency Formatting
- Uses Indonesian Rupiah (IDR)
- Thousands separator: period (.)
- Format: "Rp 1.234.567"
- No decimal places for currency

### Date Formatting
- DD/MM/YYYY format
- Appropriate for Indonesian locale

### Business Terminology
- "Pelanggan" for Customer
- "Transaksi" for Transaction
- "Cabang" for Outlet/Branch
- "Kasir" for Cashier
- "Manajer" for Manager
- Professional, business-appropriate terms

### Politeness Level
- Uses formal Indonesian ("Mohon" instead of "Tolong")
- Professional tone throughout
- Respectful error messages

## Development Workflow

### Adding New Translations

1. **Add to English ARB file** (`lib/l10n/app_en.arb`):
```json
{
  "newTranslationKey": "English text",
  "@newTranslationKey": {
    "description": "Description of the translation"
  }
}
```

2. **Add to Indonesian ARB file** (`lib/l10n/app_id.arb`):
```json
{
  "newTranslationKey": "Indonesian text"
}
```

3. **Generate localization files**:
```bash
flutter gen-l10n
```

4. **Use in code**:
```dart
Text(context.l10n.newTranslationKey)
```

### Parameterized Translations

For dynamic content:

```json
{
  "welcomeMessage": "Welcome, {username}!",
  "@welcomeMessage": {
    "description": "Welcome message with username",
    "placeholders": {
      "username": {
        "type": "String",
        "example": "John"
      }
    }
  }
}
```

Usage:
```dart
Text(context.l10n.welcomeMessage('John'))
```

### Plural Forms

For count-based messages:

```json
{
  "itemCount": "{count,plural, =0{No items} =1{1 item} other{{count} items}}",
  "@itemCount": {
    "description": "Display item count",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
```

## Testing Localization

### Manual Testing
1. Change device language to Indonesian
2. Launch app - should auto-detect and use Indonesian
3. Use language selector to switch between languages
4. Verify currency, date formatting
5. Test all major screens and error messages

### Widget Testing
```dart
testWidgets('should display Indonesian text when locale is id', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('id'),
      home: MyWidget(),
    ),
  );
  
  expect(find.text('Produk'), findsOneWidget);
});
```

## Best Practices

### 1. Context-Appropriate Terms
- Use business-specific terminology
- Maintain consistency across screens
- Professional tone for POS environment

### 2. Text Layout Considerations
- Indonesian text is typically longer than English
- Design flexible UI layouts
- Test with longest translations

### 3. Cultural Sensitivity
- Use appropriate formality level
- Consider local business practices
- Respectful error messaging

### 4. Performance
- Translations are loaded efficiently
- Minimal impact on app startup
- Locale changes are instant

### 5. Maintenance
- Keep translations up to date
- Review translations with native speakers  
- Document translation decisions

## Common Issues & Solutions

### Issue: Translations not updating
**Solution**: Run `flutter gen-l10n` and restart the app

### Issue: Missing translations
**Solution**: Ensure keys exist in both ARB files

### Issue: Locale not persisting
**Solution**: Check SharedPreferences permissions

### Issue: Currency formatting incorrect
**Solution**: Verify LocalizationHelper.formatCurrency implementation

### Issue: Date format not localized
**Solution**: Use context.formatDate() extension method

## Future Enhancements

- Add more languages (Chinese, Arabic)
- Implement RTL support for Arabic
- Advanced plural rules
- Context-aware translations
- Translation management system integration
- Professional translation review process

---

This comprehensive i18n setup provides a solid foundation for a professional, multilingual POS system with appropriate Indonesian localization and business terminology.