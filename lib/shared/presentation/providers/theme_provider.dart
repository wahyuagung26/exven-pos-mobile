import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

enum AppThemeMode {
  light,
  dark,
  system;

  ThemeMode get themeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  String get displayName {
    switch (this) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System';
    }
  }

  static AppThemeMode fromString(String value) {
    switch (value.toLowerCase()) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
      default:
        return AppThemeMode.system;
    }
  }
}

class ThemeState {
  final AppThemeMode themeMode;
  final bool isLoading;

  const ThemeState({
    required this.themeMode,
    this.isLoading = false,
  });

  ThemeState copyWith({
    AppThemeMode? themeMode,
    bool? isLoading,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  static const String _themeKey = 'theme_mode';
  SharedPreferences? _prefs;

  ThemeNotifier() : super(const ThemeState(themeMode: AppThemeMode.system)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
      final themeModeString = _prefs?.getString(_themeKey) ?? 'system';
      final themeMode = AppThemeMode.fromString(themeModeString);
      
      state = state.copyWith(themeMode: themeMode);
    } catch (e) {
      state = state.copyWith(themeMode: AppThemeMode.system);
    }
  }

  Future<void> setThemeMode(AppThemeMode themeMode) async {
    state = state.copyWith(isLoading: true);
    
    try {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs?.setString(_themeKey, themeMode.name);
      state = state.copyWith(themeMode: themeMode, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> toggleTheme() async {
    final currentMode = state.themeMode;
    AppThemeMode newMode;
    
    switch (currentMode) {
      case AppThemeMode.light:
        newMode = AppThemeMode.dark;
        break;
      case AppThemeMode.dark:
        newMode = AppThemeMode.light;
        break;
      case AppThemeMode.system:
        newMode = AppThemeMode.light;
        break;
    }
    
    await setThemeMode(newMode);
  }

  bool isDarkMode(BuildContext context) {
    switch (state.themeMode) {
      case AppThemeMode.light:
        return false;
      case AppThemeMode.dark:
        return true;
      case AppThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

  ColorScheme getCurrentColorScheme(BuildContext context) {
    return isDarkMode(context) 
        ? AppTheme.darkColorScheme 
        : AppTheme.lightColorScheme;
  }

  ThemeData getCurrentTheme(BuildContext context) {
    return isDarkMode(context) 
        ? AppTheme.darkTheme 
        : AppTheme.lightTheme;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

final currentThemeModeProvider = Provider<AppThemeMode>((ref) {
  final themeState = ref.watch(themeProvider);
  return themeState.themeMode;
});

final currentThemeDataProvider = Provider<ThemeData>((ref) {
  final themeState = ref.watch(themeProvider);
  
  switch (themeState.themeMode) {
    case AppThemeMode.light:
      return AppTheme.lightTheme;
    case AppThemeMode.dark:
      return AppTheme.darkTheme;
    case AppThemeMode.system:
      return AppTheme.lightTheme; 
  }
});

final currentColorSchemeProvider = Provider<ColorScheme>((ref) {
  final themeData = ref.watch(currentThemeDataProvider);
  return themeData.colorScheme;
});

final isDarkModeProvider = Provider.family<bool, BuildContext>((ref, context) {
  final themeNotifier = ref.watch(themeProvider.notifier);
  return themeNotifier.isDarkMode(context);
});

final themeBasedColorProvider = Provider.family<Color, Color>((ref, lightColor) {
  final colorScheme = ref.watch(currentColorSchemeProvider);
  return colorScheme.brightness == Brightness.dark
      ? _adjustColorForDarkTheme(lightColor)
      : lightColor;
});

Color _adjustColorForDarkTheme(Color lightColor) {
  final hsl = HSLColor.fromColor(lightColor);
  return hsl.withLightness((1 - hsl.lightness).clamp(0.1, 0.9)).toColor();
}

final adaptiveIconProvider = Provider.family<IconData, AdaptiveIconData>((ref, iconData) {
  final colorScheme = ref.watch(currentColorSchemeProvider);
  return colorScheme.brightness == Brightness.dark
      ? iconData.darkIcon
      : iconData.lightIcon;
});

class AdaptiveIconData {
  final IconData lightIcon;
  final IconData darkIcon;

  const AdaptiveIconData({
    required this.lightIcon,
    required this.darkIcon,
  });
}

class ThemeUtils {
  static Color getOnSurfaceColor(BuildContext context, {double opacity = 1.0}) {
    return Theme.of(context).colorScheme.onSurface.withOpacity(opacity);
  }

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color getErrorColor(BuildContext context) {
    return Theme.of(context).colorScheme.error;
  }

  static Color getWarningColor(BuildContext context) {
    return AppTheme.warningColor;
  }

  static Color getSuccessColor(BuildContext context) {
    return AppTheme.successColor;
  }

  static TextStyle getDisplayLarge(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge!;
  }

  static TextStyle getHeadlineMedium(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!;
  }

  static TextStyle getTitleLarge(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!;
  }

  static TextStyle getBodyLarge(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!;
  }

  static TextStyle getBodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  static TextStyle getLabelMedium(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!;
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color adaptiveColor(BuildContext context, Color lightColor, Color darkColor) {
    return isDarkMode(context) ? darkColor : lightColor;
  }

  static BoxShadow getElevationShadow(BuildContext context, {double elevation = 1.0}) {
    return BoxShadow(
      color: Theme.of(context).shadowColor.withOpacity(0.1 * elevation),
      blurRadius: 2.0 * elevation,
      offset: Offset(0, elevation),
    );
  }

  static BorderRadius getDefaultBorderRadius() {
    return BorderRadius.circular(8.0);
  }

  static BorderRadius getLargeBorderRadius() {
    return BorderRadius.circular(12.0);
  }

  static BorderRadius getSmallBorderRadius() {
    return BorderRadius.circular(4.0);
  }

  static EdgeInsets getDefaultPadding() {
    return const EdgeInsets.all(16.0);
  }

  static EdgeInsets getSmallPadding() {
    return const EdgeInsets.all(8.0);
  }

  static EdgeInsets getLargePadding() {
    return const EdgeInsets.all(24.0);
  }
}