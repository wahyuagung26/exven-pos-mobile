/// BuildContext extensions for common UI operations
/// 
/// This file contains extension methods on BuildContext for theme access,
/// navigation helpers, snackbar display, dialogs, and other common UI operations.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Extension on BuildContext for theme-related operations
extension ThemeExtension on BuildContext {
  /// Get the current theme data
  ThemeData get theme => Theme.of(this);
  
  /// Get the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;
  
  /// Get the current text theme
  TextTheme get textTheme => theme.textTheme;
  
  /// Check if the current theme is dark
  bool get isDarkTheme => theme.brightness == Brightness.dark;
  
  /// Get primary color
  Color get primaryColor => colorScheme.primary;
  
  /// Get secondary color
  Color get secondaryColor => colorScheme.secondary;
  
  /// Get surface color
  Color get surfaceColor => colorScheme.surface;
  
  /// Get background color
  Color get backgroundColor => colorScheme.background;
  
  /// Get error color
  Color get errorColor => colorScheme.error;
  
  /// Get on-primary color (text color on primary background)
  Color get onPrimaryColor => colorScheme.onPrimary;
  
  /// Get on-surface color (text color on surface background)
  Color get onSurfaceColor => colorScheme.onSurface;
  
  /// Get disabled color
  Color get disabledColor => colorScheme.onSurface.withOpacity(0.38);
  
  /// Get divider color
  Color get dividerColor => colorScheme.outline.withOpacity(0.12);
}

/// Extension on BuildContext for typography and text styles
extension TypographyExtension on BuildContext {
  /// Headline text styles
  TextStyle? get headlineLarge => textTheme.headlineLarge;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineSmall => textTheme.headlineSmall;
  
  /// Title text styles
  TextStyle? get titleLarge => textTheme.titleLarge;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleSmall => textTheme.titleSmall;
  
  /// Body text styles
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodySmall => textTheme.bodySmall;
  
  /// Label text styles
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelSmall => textTheme.labelSmall;
  
  /// Display text styles
  TextStyle? get displayLarge => textTheme.displayLarge;
  TextStyle? get displayMedium => textTheme.displayMedium;
  TextStyle? get displaySmall => textTheme.displaySmall;
}

/// Extension on BuildContext for device information
extension DeviceExtension on BuildContext {
  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;
  
  /// Get screen width
  double get screenWidth => screenSize.width;
  
  /// Get screen height
  double get screenHeight => screenSize.height;
  
  /// Get device pixel ratio
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  
  /// Check if device is tablet (width > 600)
  bool get isTablet => screenWidth > 600;
  
  /// Check if device is mobile (width <= 600)
  bool get isMobile => screenWidth <= 600;
  
  /// Check if device is large screen (width > 900)
  bool get isDesktop => screenWidth > 900;
  
  /// Get safe area padding
  EdgeInsets get padding => MediaQuery.of(this).padding;
  
  /// Get view insets (keyboard height)
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  
  /// Check if keyboard is open
  bool get isKeyboardOpen => viewInsets.bottom > 0;
  
  /// Get status bar height
  double get statusBarHeight => padding.top;
  
  /// Get bottom safe area height
  double get bottomSafeArea => padding.bottom;
  
  /// Get available height (screen height - status bar - bottom safe area)
  double get availableHeight => 
      screenHeight - statusBarHeight - bottomSafeArea;
}

/// Extension on BuildContext for navigation operations
extension NavigationExtension on BuildContext {
  /// Navigate to a named route
  void pushNamed(String routeName, {Object? extra}) {
    GoRouter.of(this).pushNamed(routeName, extra: extra);
  }
  
  /// Navigate and replace current route
  void goNamed(String routeName, {Object? extra}) {
    GoRouter.of(this).goNamed(routeName, extra: extra);
  }
  
  /// Navigate and replace entire stack
  void pushReplacementNamed(String routeName, {Object? extra}) {
    GoRouter.of(this).pushReplacementNamed(routeName, extra: extra);
  }
  
  /// Pop current route
  void pop<T>([T? result]) {
    GoRouter.of(this).pop(result);
  }
  
  /// Pop until a specific route
  void popUntilNamed(String routeName) {
    while (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    }
    GoRouter.of(this).pushReplacementNamed(routeName);
  }
  
  /// Check if can pop
  bool get canPop => GoRouter.of(this).canPop();
  
  /// Get current route location
  String get currentLocation => GoRouter.of(this).location;
}

/// Extension on BuildContext for snackbar operations
extension SnackbarExtension on BuildContext {
  /// Show a basic snackbar
  void showSnackbar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }
  
  /// Show success snackbar with green background
  void showSuccessSnackbar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  /// Show error snackbar with red background
  void showErrorSnackbar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: errorColor,
        duration: duration ?? const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  /// Show warning snackbar with orange background
  void showWarningSnackbar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: duration ?? const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  /// Show info snackbar with blue background
  void showInfoSnackbar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: duration ?? const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  /// Hide current snackbar
  void hideSnackbar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }
}

/// Extension on BuildContext for dialog operations
extension DialogExtension on BuildContext {
  /// Show a basic alert dialog
  Future<T?> showAlertDialog<T>({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<T>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: onCancel ?? () => context.pop(),
              child: Text(cancelText),
            ),
          if (confirmText != null)
            TextButton(
              onPressed: onConfirm ?? () => context.pop(true),
              child: Text(confirmText),
            ),
        ],
      ),
    );
  }
  
  /// Show confirmation dialog
  Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Ya',
    String cancelText = 'Batal',
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
  
  /// Show loading dialog
  void showLoadingDialog({String message = 'Loading...'}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
  
  /// Hide loading dialog
  void hideLoadingDialog() {
    if (canPop) pop();
  }
  
  /// Show error dialog
  Future<void> showErrorDialog({
    String title = 'Error',
    required String message,
    String buttonText = 'OK',
  }) {
    return showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: errorColor),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
  
  /// Show success dialog
  Future<void> showSuccessDialog({
    String title = 'Sukses',
    required String message,
    String buttonText = 'OK',
  }) {
    return showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}

/// Extension on BuildContext for bottom sheet operations
extension BottomSheetExtension on BuildContext {
  /// Show modal bottom sheet
  Future<T?> showBottomSheet<T>({
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: builder,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }
  
  /// Show custom bottom sheet with predefined styling
  Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    String? title,
    bool showHandle = true,
    double? height,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        height: height,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showHandle)
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: context.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            if (title != null) ...[
              Text(
                title,
                style: context.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}

/// Extension on BuildContext for localization
extension LocalizationExtension on BuildContext {
  /// Get current locale
  Locale get locale => Localizations.localeOf(this);
  
  /// Check if current locale is Indonesian
  bool get isIndonesian => locale.languageCode == 'id';
  
  /// Check if current locale is English
  bool get isEnglish => locale.languageCode == 'en';
  
  /// Get current language code
  String get languageCode => locale.languageCode;
  
  /// Get text direction for current locale
  TextDirection get textDirection => Directionality.of(this);
  
  /// Check if current locale is RTL
  bool get isRTL => textDirection == TextDirection.rtl;
}

/// Extension on BuildContext for focus operations
extension FocusExtension on BuildContext {
  /// Unfocus current focus node (hide keyboard)
  void unfocus() {
    FocusScope.of(this).unfocus();
  }
  
  /// Request focus for a specific node
  void requestFocus([FocusNode? node]) {
    if (node != null) {
      FocusScope.of(this).requestFocus(node);
    } else {
      FocusScope.of(this).requestFocus();
    }
  }
  
  /// Move focus to next field
  void nextFocus() {
    FocusScope.of(this).nextFocus();
  }
  
  /// Move focus to previous field
  void previousFocus() {
    FocusScope.of(this).previousFocus();
  }
}

/// Extension on BuildContext for accessibility
extension AccessibilityExtension on BuildContext {
  /// Check if high contrast is enabled
  bool get isHighContrast => 
      MediaQuery.of(this).highContrast;
  
  /// Check if animations are disabled
  bool get disableAnimations => 
      MediaQuery.of(this).disableAnimations;
  
  /// Check if bold text is enabled
  bool get boldText => 
      MediaQuery.of(this).boldText;
  
  /// Get text scale factor
  double get textScaleFactor => 
      MediaQuery.of(this).textScaleFactor;
  
  /// Check if device supports touch
  bool get supportsTouch => 
      MediaQuery.of(this).gestureSettings.touchSlop != null;
}