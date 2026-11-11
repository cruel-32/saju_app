import 'package:flutter/material.dart';

import '../domain/saju.dart';

/// 샘플 화면(캔버스)과 같은 색상 값.
abstract final class AppColors {
  static const background = Color(0xFF121419);
  static const surface = Color(0xFF1B1E25);
  static const surfaceHigh = Color(0xFF23272F);
  static const surfaceAccent = Color(0xFF1F2229);
  static const navBar = Color(0xFF16181E);
  static const border = Color(0xFF2C313B);

  static const text = Color(0xFFEDEBE6);
  static const textMuted = Color(0xFFA3A6AE);
  static const gold = Color(0xFFD6B56E);

  static const free = Color(0xFF8FD3A6);
  static const freeBg = Color(0xFF2A3A2F);
  static const paid = Color(0xFFC4AEF0);
  static const paidBg = Color(0xFF352C46);

  /// 오행별 글자 색.
  static Color ohaeng(Ohaeng o) => switch (o) {
        Ohaeng.wood => const Color(0xFF6CC08A),
        Ohaeng.fire => const Color(0xFFEE7468),
        Ohaeng.earth => const Color(0xFFE2AE4A),
        Ohaeng.metal => const Color(0xFFD3D6DC),
        Ohaeng.water => const Color(0xFF6E9BF2),
      };
}

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.gold,
    brightness: Brightness.dark,
  ).copyWith(
    primary: AppColors.gold,
    onPrimary: AppColors.background,
    surface: AppColors.background,
    onSurface: AppColors.text,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.background,
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.surfaceHigh,
      contentTextStyle: TextStyle(color: AppColors.text),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.navBar,
      indicatorColor: AppColors.gold.withValues(alpha: 0.16),
      height: 68,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: 11,
          color: states.contains(WidgetState.selected)
              ? AppColors.gold
              : AppColors.textMuted,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.gold
              : AppColors.textMuted,
        ),
      ),
    ),
  );
}
