import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Based on Material Design 3
  static const Color primary = Color(0xFF6750A4);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFE9DDFF);
  static const Color onPrimaryContainer = Color(0xFF22005D);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF635B70);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE9DEF8);
  static const Color onSecondaryContainer = Color(0xFF1F182B);
  
  // Tertiary Colors
  static const Color tertiary = Color(0xFF7E5260);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFFFD9E3);
  static const Color onTertiaryContainer = Color(0xFF31101D);
  
  // Error Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);
  
  // Success Colors
  static const Color success = Color(0xFF006D40);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color successContainer = Color(0xFF8FF7B8);
  static const Color onSuccessContainer = Color(0xFF002112);
  
  // Warning Colors
  static const Color warning = Color(0xFF825500);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color warningContainer = Color(0xFFFFDDAE);
  static const Color onWarningContainer = Color(0xFF2A1800);
  
  // Info Colors
  static const Color info = Color(0xFF006493);
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color infoContainer = Color(0xFFC8E6FF);
  static const Color onInfoContainer = Color(0xFF001E30);
  
  // Surface Colors - Light Theme
  static const Color surface = Color(0xFFFEF7FF);
  static const Color onSurface = Color(0xFF1D1B20);
  static const Color surfaceVariant = Color(0xFFE7E0EB);
  static const Color onSurfaceVariant = Color(0xFF49454E);
  static const Color surfaceTint = primary;
  
  // Background Colors - Light Theme
  static const Color background = Color(0xFFFEF7FF);
  static const Color onBackground = Color(0xFF1D1B20);
  
  // Outline Colors
  static const Color outline = Color(0xFF7A757F);
  static const Color outlineVariant = Color(0xFFCAC4CF);
  
  // Dark Theme Colors
  static const Color primaryDark = Color(0xFFCFBDFF);
  static const Color onPrimaryDark = Color(0xFF381E72);
  static const Color primaryContainerDark = Color(0xFF4F378A);
  static const Color onPrimaryContainerDark = Color(0xFFE9DDFF);
  
  static const Color secondaryDark = Color(0xFFCCC2DB);
  static const Color onSecondaryDark = Color(0xFF352D40);
  static const Color secondaryContainerDark = Color(0xFF4B4358);
  static const Color onSecondaryContainerDark = Color(0xFFE9DEF8);
  
  static const Color tertiaryDark = Color(0xFFEFB8C8);
  static const Color onTertiaryDark = Color(0xFF4A2532);
  static const Color tertiaryContainerDark = Color(0xFF633B48);
  static const Color onTertiaryContainerDark = Color(0xFFFFD9E3);
  
  static const Color errorDark = Color(0xFFFFB4AB);
  static const Color onErrorDark = Color(0xFF690005);
  static const Color errorContainerDark = Color(0xFF93000A);
  static const Color onErrorContainerDark = Color(0xFFFFDAD6);
  
  static const Color successDark = Color(0xFF73DA9D);
  static const Color onSuccessDark = Color(0xFF003822);
  static const Color successContainerDark = Color(0xFF005230);
  static const Color onSuccessContainerDark = Color(0xFF8FF7B8);
  
  static const Color warningDark = Color(0xFFE9C46A);
  static const Color onWarningDark = Color(0xFF452B00);
  static const Color warningContainerDark = Color(0xFF633F00);
  static const Color onWarningContainerDark = Color(0xFFFFDDAE);
  
  static const Color infoDark = Color(0xFF8BCEFF);
  static const Color onInfoDark = Color(0xFF003450);
  static const Color infoContainerDark = Color(0xFF004C6F);
  static const Color onInfoContainerDark = Color(0xFFC8E6FF);
  
  static const Color surfaceDark = Color(0xFF141218);
  static const Color onSurfaceDark = Color(0xFFE6E0E9);
  static const Color surfaceVariantDark = Color(0xFF49454E);
  static const Color onSurfaceVariantDark = Color(0xFFCAC4CF);
  
  static const Color backgroundDark = Color(0xFF141218);
  static const Color onBackgroundDark = Color(0xFFE6E0E9);
  
  static const Color outlineDark = Color(0xFF948F99);
  static const Color outlineVariantDark = Color(0xFF49454E);
  
  // Neutral Colors
  static const Color neutral = Color(0xFF5F5F5F);
  static const Color neutralVariant = Color(0xFF49454E);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1D1B20);
  static const Color textSecondary = Color(0xFF49454E);
  static const Color textDisabled = Color(0xFF938F99);
  static const Color textInverse = Color(0xFFF4EFF4);
  
  static const Color textPrimaryDark = Color(0xFFE6E0E9);
  static const Color textSecondaryDark = Color(0xFFCAC4CF);
  static const Color textDisabledDark = Color(0xFF938F99);
  static const Color textInverseDark = Color(0xFF322F35);
  
  // App-specific Colors
  static const Color cashColor = success;
  static const Color cardColor = info;
  static const Color transferColor = warning;
  static const Color ewalletColor = tertiary;
  
  // POS Specific Colors
  static const Color receiptBackground = Color(0xFFFAFAFA);
  static const Color receiptBorder = Color(0xFFE0E0E0);
  static const Color productCardBackground = Color(0xFFFFFFFF);
  static const Color productCardShadow = Color(0x0D000000);
  
  static const Color stockLow = Color(0xFFFF6B35);
  static const Color stockMedium = Color(0xFFFFB830);
  static const Color stockHigh = Color(0xFF4CAF50);
  
  static const Color discountColor = Color(0xFFE91E63);
  static const Color taxColor = Color(0xFF607D8B);
  
  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF6750A4),
    Color(0xFF7E5260),
    Color(0xFF006D40),
    Color(0xFF825500),
    Color(0xFF006493),
    Color(0xFFBA1A1A),
    Color(0xFF8E24AA),
    Color(0xFF0277BD),
    Color(0xFF2E7D32),
    Color(0xFFF57C00),
  ];
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6750A4),
      Color(0xFF4F378A),
    ],
  );
  
  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4CAF50),
      Color(0xFF2E7D32),
    ],
  );
  
  static const LinearGradient warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF9800),
      Color(0xFFF57C00),
    ],
  );
  
  static const LinearGradient errorGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE53935),
      Color(0xFFC62828),
    ],
  );
  
  // Shadow Colors
  static const Color shadowColor = Color(0x1A000000);
  static const Color elevationShadowColor = Color(0x0F000000);
  
  // Border Colors
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color borderColorDark = Color(0xFF3A3A3A);
  static const Color focusedBorderColor = primary;
  static const Color errorBorderColor = error;
  
  // Input Field Colors
  static const Color inputFillColor = Color(0xFFF5F5F5);
  static const Color inputFillColorDark = Color(0xFF2A2A2A);
  static const Color inputHintColor = Color(0xFF9E9E9E);
  static const Color inputHintColorDark = Color(0xFF757575);
  
  // Divider Colors
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color dividerColorDark = Color(0xFF3A3A3A);
  
  // Shimmer Colors
  static const Color shimmerBaseColor = Color(0xFFE0E0E0);
  static const Color shimmerHighlightColor = Color(0xFFF5F5F5);
  static const Color shimmerBaseColorDark = Color(0xFF2A2A2A);
  static const Color shimmerHighlightColorDark = Color(0xFF3A3A3A);
  
  // Status Badge Colors
  static const Color activeStatusColor = success;
  static const Color inactiveStatusColor = Color(0xFF9E9E9E);
  static const Color pendingStatusColor = warning;
  static const Color completedStatusColor = success;
  static const Color cancelledStatusColor = error;
  static const Color refundedStatusColor = info;
  
  // Helper method to get colors based on theme
  static ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    background: background,
    onBackground: onBackground,
    surface: surface,
    onSurface: onSurface,
    surfaceVariant: surfaceVariant,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    outlineVariant: outlineVariant,
    shadow: shadowColor,
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF322F35),
    onInverseSurface: Color(0xFFF4EFF4),
    inversePrimary: primaryDark,
    surfaceTint: surfaceTint,
  );
  
  static ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: primaryDark,
    onPrimary: onPrimaryDark,
    primaryContainer: primaryContainerDark,
    onPrimaryContainer: onPrimaryContainerDark,
    secondary: secondaryDark,
    onSecondary: onSecondaryDark,
    secondaryContainer: secondaryContainerDark,
    onSecondaryContainer: onSecondaryContainerDark,
    tertiary: tertiaryDark,
    onTertiary: onTertiaryDark,
    tertiaryContainer: tertiaryContainerDark,
    onTertiaryContainer: onTertiaryContainerDark,
    error: errorDark,
    onError: onErrorDark,
    errorContainer: errorContainerDark,
    onErrorContainer: onErrorContainerDark,
    background: backgroundDark,
    onBackground: onBackgroundDark,
    surface: surfaceDark,
    onSurface: onSurfaceDark,
    surfaceVariant: surfaceVariantDark,
    onSurfaceVariant: onSurfaceVariantDark,
    outline: outlineDark,
    outlineVariant: outlineVariantDark,
    shadow: shadowColor,
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFE6E0E9),
    onInverseSurface: Color(0xFF322F35),
    inversePrimary: primary,
    surfaceTint: primaryDark,
  );
}