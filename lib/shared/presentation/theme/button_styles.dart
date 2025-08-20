import 'package:flutter/material.dart';

class AppButtonStyles {
  static ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );

  static FilledButtonThemeData get filledButtonTheme => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );

  static OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: const BorderSide(width: 1.5),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );

  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );

  static ButtonStyle get primaryFilledButton => FilledButton.styleFrom(
    backgroundColor: const Color(0xFF2563EB),
    foregroundColor: Colors.white,
    disabledBackgroundColor: const Color(0xFFD1D5DB),
    disabledForegroundColor: const Color(0xFF9CA3AF),
  );

  static ButtonStyle get secondaryFilledButton => FilledButton.styleFrom(
    backgroundColor: const Color(0xFF059669),
    foregroundColor: Colors.white,
    disabledBackgroundColor: const Color(0xFFD1D5DB),
    disabledForegroundColor: const Color(0xFF9CA3AF),
  );

  static ButtonStyle get warningFilledButton => FilledButton.styleFrom(
    backgroundColor: const Color(0xFFEA580C),
    foregroundColor: Colors.white,
    disabledBackgroundColor: const Color(0xFFD1D5DB),
    disabledForegroundColor: const Color(0xFF9CA3AF),
  );

  static ButtonStyle get dangerFilledButton => FilledButton.styleFrom(
    backgroundColor: const Color(0xFFDC2626),
    foregroundColor: Colors.white,
    disabledBackgroundColor: const Color(0xFFD1D5DB),
    disabledForegroundColor: const Color(0xFF9CA3AF),
  );

  static ButtonStyle get successFilledButton => FilledButton.styleFrom(
    backgroundColor: const Color(0xFF16A34A),
    foregroundColor: Colors.white,
    disabledBackgroundColor: const Color(0xFFD1D5DB),
    disabledForegroundColor: const Color(0xFF9CA3AF),
  );

  static ButtonStyle get primaryOutlinedButton => OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF2563EB),
    side: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
    disabledForegroundColor: const Color(0xFF9CA3AF),
    disabledBackgroundColor: Colors.transparent,
  ).copyWith(
    side: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return const BorderSide(color: Color(0xFFD1D5DB), width: 1.5);
      }
      return const BorderSide(color: Color(0xFF2563EB), width: 1.5);
    }),
  );

  static ButtonStyle get secondaryOutlinedButton => OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF059669),
    side: const BorderSide(color: Color(0xFF059669), width: 1.5),
    disabledForegroundColor: const Color(0xFF9CA3AF),
    disabledBackgroundColor: Colors.transparent,
  ).copyWith(
    side: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return const BorderSide(color: Color(0xFFD1D5DB), width: 1.5);
      }
      return const BorderSide(color: Color(0xFF059669), width: 1.5);
    }),
  );

  static ButtonStyle get warningOutlinedButton => OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFFEA580C),
    side: const BorderSide(color: Color(0xFFEA580C), width: 1.5),
    disabledForegroundColor: const Color(0xFF9CA3AF),
    disabledBackgroundColor: Colors.transparent,
  ).copyWith(
    side: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return const BorderSide(color: Color(0xFFD1D5DB), width: 1.5);
      }
      return const BorderSide(color: Color(0xFFEA580C), width: 1.5);
    }),
  );

  static ButtonStyle get dangerOutlinedButton => OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFFDC2626),
    side: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
    disabledForegroundColor: const Color(0xFF9CA3AF),
    disabledBackgroundColor: Colors.transparent,
  ).copyWith(
    side: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return const BorderSide(color: Color(0xFFD1D5DB), width: 1.5);
      }
      return const BorderSide(color: Color(0xFFDC2626), width: 1.5);
    }),
  );

  static ButtonStyle get successOutlinedButton => OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF16A34A),
    side: const BorderSide(color: Color(0xFF16A34A), width: 1.5),
    disabledForegroundColor: const Color(0xFF9CA3AF),
    disabledBackgroundColor: Colors.transparent,
  ).copyWith(
    side: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return const BorderSide(color: Color(0xFFD1D5DB), width: 1.5);
      }
      return const BorderSide(color: Color(0xFF16A34A), width: 1.5);
    }),
  );

  static ButtonStyle get smallButton => ButtonStyle(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    textStyle: MaterialStateProperty.all(
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    ),
    minimumSize: MaterialStateProperty.all(Size.zero),
  );

  static ButtonStyle get largeButton => ButtonStyle(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    ),
    textStyle: MaterialStateProperty.all(
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  static ButtonStyle get iconButton => ButtonStyle(
    padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    minimumSize: MaterialStateProperty.all(const Size(40, 40)),
  );

  static ButtonStyle get roundedButton => ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  static ButtonStyle get fullWidthButton => ButtonStyle(
    minimumSize: MaterialStateProperty.all(const Size.fromHeight(48)),
  );

  static ButtonStyle get compactButton => ButtonStyle(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    ),
    textStyle: MaterialStateProperty.all(
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    ),
    minimumSize: MaterialStateProperty.all(Size.zero),
  );

  static Widget primaryButton({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    bool fullWidth = false,
  }) {
    final button = isLoading
        ? FilledButton(
            onPressed: null,
            style: primaryFilledButton,
            child: const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          )
        : icon != null
            ? FilledButton.icon(
                onPressed: onPressed,
                style: primaryFilledButton,
                icon: Icon(icon),
                label: Text(text),
              )
            : FilledButton(
                onPressed: onPressed,
                style: primaryFilledButton,
                child: Text(text),
              );

    return fullWidth
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }

  static Widget secondaryButton({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    bool fullWidth = false,
  }) {
    final button = isLoading
        ? OutlinedButton(
            onPressed: null,
            style: secondaryOutlinedButton,
            child: const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          )
        : icon != null
            ? OutlinedButton.icon(
                onPressed: onPressed,
                style: secondaryOutlinedButton,
                icon: Icon(icon),
                label: Text(text),
              )
            : OutlinedButton(
                onPressed: onPressed,
                style: secondaryOutlinedButton,
                child: Text(text),
              );

    return fullWidth
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }

  static Widget dangerButton({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    bool fullWidth = false,
    bool outlined = false,
  }) {
    final ButtonStyle style = outlined ? dangerOutlinedButton : dangerFilledButton;
    
    final button = isLoading
        ? (outlined ? OutlinedButton : FilledButton)(
            onPressed: null,
            style: style,
            child: const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          )
        : icon != null
            ? (outlined
                ? OutlinedButton.icon(
                    onPressed: onPressed,
                    style: style,
                    icon: Icon(icon),
                    label: Text(text),
                  )
                : FilledButton.icon(
                    onPressed: onPressed,
                    style: style,
                    icon: Icon(icon),
                    label: Text(text),
                  ))
            : (outlined
                ? OutlinedButton(
                    onPressed: onPressed,
                    style: style,
                    child: Text(text),
                  )
                : FilledButton(
                    onPressed: onPressed,
                    style: style,
                    child: Text(text),
                  ));

    return fullWidth
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }
}