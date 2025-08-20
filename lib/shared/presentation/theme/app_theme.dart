import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'text_styles.dart';
import 'button_styles.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF2563EB);
  static const Color _primaryContainerColor = Color(0xFFDBEAFE);
  static const Color _secondaryColor = Color(0xFF059669);
  static const Color _secondaryContainerColor = Color(0xFFD1FAE5);
  static const Color _errorColor = Color(0xFFDC2626);
  static const Color _errorContainerColor = Color(0xFFFEE2E2);
  static const Color _warningColor = Color(0xFFEA580C);
  static const Color _warningContainerColor = Color(0xFFFFEDD5);
  static const Color _successColor = Color(0xFF16A34A);
  static const Color _successContainerColor = Color(0xFFDCFCE7);

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: _primaryColor,
      onPrimary: Colors.white,
      primaryContainer: _primaryContainerColor,
      onPrimaryContainer: Color(0xFF1E3A8A),
      secondary: _secondaryColor,
      onSecondary: Colors.white,
      secondaryContainer: _secondaryContainerColor,
      onSecondaryContainer: Color(0xFF064E3B),
      tertiary: Color(0xFF7C3AED),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFEDE9FE),
      onTertiaryContainer: Color(0xFF5B21B6),
      error: _errorColor,
      onError: Colors.white,
      errorContainer: _errorContainerColor,
      onErrorContainer: Color(0xFF7F1D1D),
      background: Color(0xFFFAFAFA),
      onBackground: Color(0xFF111827),
      surface: Colors.white,
      onSurface: Color(0xFF111827),
      surfaceVariant: Color(0xFFF3F4F6),
      onSurfaceVariant: Color(0xFF6B7280),
      outline: Color(0xFFD1D5DB),
      outlineVariant: Color(0xFFE5E7EB),
      shadow: Colors.black26,
      scrim: Colors.black54,
      inverseSurface: Color(0xFF374151),
      onInverseSurface: Color(0xFFF9FAFB),
      inversePrimary: Color(0xFF93C5FD),
      surfaceTint: _primaryColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Inter',
      textTheme: AppTextStyles.lightTextTheme,
      elevatedButtonTheme: AppButtonStyles.elevatedButtonTheme,
      filledButtonTheme: AppButtonStyles.filledButtonTheme,
      outlinedButtonTheme: AppButtonStyles.outlinedButtonTheme,
      textButtonTheme: AppButtonStyles.textButtonTheme,
      appBarTheme: _lightAppBarTheme,
      cardTheme: _cardTheme,
      chipTheme: _lightChipTheme,
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE5E7EB),
        thickness: 1,
      ),
      inputDecorationTheme: _lightInputDecorationTheme,
      listTileTheme: _lightListTileTheme,
      navigationBarTheme: _lightNavigationBarTheme,
      navigationDrawerTheme: _lightNavigationDrawerTheme,
      popupMenuTheme: _lightPopupMenuTheme,
      snackBarTheme: _lightSnackBarTheme,
      switchTheme: _switchTheme,
      checkboxTheme: _checkboxTheme,
      radioTheme: _radioTheme,
      sliderTheme: _sliderTheme,
      tabBarTheme: _lightTabBarTheme,
      bottomSheetTheme: _bottomSheetTheme,
      dialogTheme: _dialogTheme,
      expansionTileTheme: _expansionTileTheme,
    );
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF60A5FA),
      onPrimary: Color(0xFF1E3A8A),
      primaryContainer: Color(0xFF1E40AF),
      onPrimaryContainer: Color(0xFFDBEAFE),
      secondary: Color(0xFF34D399),
      onSecondary: Color(0xFF064E3B),
      secondaryContainer: Color(0xFF047857),
      onSecondaryContainer: Color(0xFFD1FAE5),
      tertiary: Color(0xFFA78BFA),
      onTertiary: Color(0xFF5B21B6),
      tertiaryContainer: Color(0xFF7C3AED),
      onTertiaryContainer: Color(0xFFEDE9FE),
      error: Color(0xFFF87171),
      onError: Color(0xFF7F1D1D),
      errorContainer: Color(0xFFDC2626),
      onErrorContainer: Color(0xFFFEE2E2),
      background: Color(0xFF0F172A),
      onBackground: Color(0xFFF1F5F9),
      surface: Color(0xFF1E293B),
      onSurface: Color(0xFFF1F5F9),
      surfaceVariant: Color(0xFF334155),
      onSurfaceVariant: Color(0xFF94A3B8),
      outline: Color(0xFF475569),
      outlineVariant: Color(0xFF64748B),
      shadow: Colors.black54,
      scrim: Colors.black87,
      inverseSurface: Color(0xFFF1F5F9),
      onInverseSurface: Color(0xFF0F172A),
      inversePrimary: _primaryColor,
      surfaceTint: Color(0xFF60A5FA),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Inter',
      textTheme: AppTextStyles.darkTextTheme,
      elevatedButtonTheme: AppButtonStyles.elevatedButtonTheme,
      filledButtonTheme: AppButtonStyles.filledButtonTheme,
      outlinedButtonTheme: AppButtonStyles.outlinedButtonTheme,
      textButtonTheme: AppButtonStyles.textButtonTheme,
      appBarTheme: _darkAppBarTheme,
      cardTheme: _cardTheme,
      chipTheme: _darkChipTheme,
      dividerTheme: const DividerThemeData(
        color: Color(0xFF475569),
        thickness: 1,
      ),
      inputDecorationTheme: _darkInputDecorationTheme,
      listTileTheme: _darkListTileTheme,
      navigationBarTheme: _darkNavigationBarTheme,
      navigationDrawerTheme: _darkNavigationDrawerTheme,
      popupMenuTheme: _darkPopupMenuTheme,
      snackBarTheme: _darkSnackBarTheme,
      switchTheme: _switchTheme,
      checkboxTheme: _checkboxTheme,
      radioTheme: _radioTheme,
      sliderTheme: _sliderTheme,
      tabBarTheme: _darkTabBarTheme,
      bottomSheetTheme: _bottomSheetTheme,
      dialogTheme: _dialogTheme,
      expansionTileTheme: _expansionTileTheme,
    );
  }

  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 1,
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF111827),
    surfaceTintColor: _primaryColor,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: TextStyle(
      color: Color(0xFF111827),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
  );

  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 1,
    backgroundColor: Color(0xFF1E293B),
    foregroundColor: Color(0xFFF1F5F9),
    surfaceTintColor: Color(0xFF60A5FA),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: TextStyle(
      color: Color(0xFFF1F5F9),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
  );

  static const CardTheme _cardTheme = CardTheme(
    elevation: 1,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  static const ChipThemeData _lightChipTheme = ChipThemeData(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  static const ChipThemeData _darkChipTheme = ChipThemeData(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  static const InputDecorationTheme _lightInputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFFD1D5DB)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: _primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: _errorColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: _errorColor, width: 2),
    ),
  );

  static const InputDecorationTheme _darkInputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFF475569)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFF60A5FA), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFFF87171)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFFF87171), width: 2),
    ),
  );

  static const ListTileThemeData _lightListTileTheme = ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  static const ListTileThemeData _darkListTileTheme = ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  static const NavigationBarThemeData _lightNavigationBarTheme = NavigationBarThemeData(
    height: 80,
    elevation: 1,
    labelTextStyle: MaterialStatePropertyAll(
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    ),
  );

  static const NavigationBarThemeData _darkNavigationBarTheme = NavigationBarThemeData(
    height: 80,
    elevation: 1,
    labelTextStyle: MaterialStatePropertyAll(
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    ),
  );

  static const NavigationDrawerThemeData _lightNavigationDrawerTheme = NavigationDrawerThemeData(
    elevation: 1,
  );

  static const NavigationDrawerThemeData _darkNavigationDrawerTheme = NavigationDrawerThemeData(
    elevation: 1,
  );

  static const PopupMenuThemeData _lightPopupMenuTheme = PopupMenuThemeData(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  static const PopupMenuThemeData _darkPopupMenuTheme = PopupMenuThemeData(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  static const SnackBarThemeData _lightSnackBarTheme = SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    margin: EdgeInsets.all(16),
  );

  static const SnackBarThemeData _darkSnackBarTheme = SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    margin: EdgeInsets.all(16),
  );

  static SwitchThemeData get _switchTheme => SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      return const Color(0xFF9CA3AF);
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return _primaryColor;
      }
      return const Color(0xFFD1D5DB);
    }),
  );

  static CheckboxThemeData get _checkboxTheme => CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return _primaryColor;
      }
      return Colors.transparent;
    }),
    checkColor: MaterialStateProperty.all(Colors.white),
    side: const BorderSide(color: Color(0xFFD1D5DB), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );

  static RadioThemeData get _radioTheme => RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return _primaryColor;
      }
      return const Color(0xFFD1D5DB);
    }),
  );

  static SliderThemeData get _sliderTheme => SliderThemeData(
    activeTrackColor: _primaryColor,
    inactiveTrackColor: const Color(0xFFE5E7EB),
    thumbColor: _primaryColor,
    overlayColor: _primaryContainerColor,
    trackHeight: 4,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
  );

  static const TabBarTheme _lightTabBarTheme = TabBarTheme(
    indicatorColor: _primaryColor,
    labelColor: _primaryColor,
    unselectedLabelColor: Color(0xFF6B7280),
    labelStyle: TextStyle(fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
  );

  static const TabBarTheme _darkTabBarTheme = TabBarTheme(
    indicatorColor: Color(0xFF60A5FA),
    labelColor: Color(0xFF60A5FA),
    unselectedLabelColor: Color(0xFF94A3B8),
    labelStyle: TextStyle(fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
  );

  static const BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
  );

  static const DialogTheme _dialogTheme = DialogTheme(
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );

  static const ExpansionTileThemeData _expansionTileTheme = ExpansionTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  static ColorScheme get lightColorScheme => lightTheme.colorScheme;
  static ColorScheme get darkColorScheme => darkTheme.colorScheme;

  static Color get warningColor => _warningColor;
  static Color get warningContainerColor => _warningContainerColor;
  static Color get successColor => _successColor;
  static Color get successContainerColor => _successContainerColor;
}