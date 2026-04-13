import 'package:flutter/material.dart';

/// Theme extension for application colors
///
/// Provides semantic color tokens that adapt to light/dark themes.
/// Use these colors instead of hardcoded values for better theme support.
///
/// Example:
/// ```dart
/// Container(
///   color: context.appColors.primary,
///   child: Text(
///     'Hello',
///     style: TextStyle(color: context.appColors.onPrimary),
///   ),
/// )
/// ```
class AppColors implements ThemeExtension<AppColors> {
  // Base colors
  final Color white;
  final Color black;
  final Color transparent;

  // Brand colors (Material palette)
  final MaterialColor brand;
  final MaterialColor grayLight;
  final MaterialColor grayDark;

  // Semantic status colors
  final Color warning;
  final Color error;
  final Color success;
  final Color info;

  // Primary/Secondary/Tertiary semantic colors
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;

  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;

  // Surface colors
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;

  // Background colors
  final Color background;
  final Color onBackground;

  // Border and divider colors
  final Color outline;
  final Color outlineVariant;

  // Text colors
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;

  const AppColors({
    required this.white,
    required this.black,
    required this.transparent,
    required this.brand,
    required this.grayLight,
    required this.grayDark,
    required this.error,
    required this.warning,
    required this.success,
    required this.info,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.background,
    required this.onBackground,
    required this.outline,
    required this.outlineVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? white,
    Color? black,
    Color? transparent,
    MaterialColor? brand,
    MaterialColor? grayLight,
    MaterialColor? grayDark,
    Color? warning,
    Color? error,
    Color? success,
    Color? info,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? background,
    Color? onBackground,
    Color? outline,
    Color? outlineVariant,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
  }) {
    return AppColors(
      white: white ?? this.white,
      black: black ?? this.black,
      transparent: transparent ?? this.transparent,
      brand: brand ?? this.brand,
      grayLight: grayLight ?? this.grayLight,
      grayDark: grayDark ?? this.grayDark,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      success: success ?? this.success,
      info: info ?? this.info,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDisabled: textDisabled ?? this.textDisabled,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      transparent: Color.lerp(transparent, other.transparent, t)!,
      brand: _lerpMaterialColor(brand, other.brand, t),
      grayLight: _lerpMaterialColor(grayLight, other.grayLight, t),
      grayDark: _lerpMaterialColor(grayDark, other.grayDark, t),
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      info: Color.lerp(info, other.info, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer:
          Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer:
          Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer:
          Color.lerp(secondaryContainer, other.secondaryContainer, t)!,
      onSecondaryContainer:
          Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      tertiaryContainer:
          Color.lerp(tertiaryContainer, other.tertiaryContainer, t)!,
      onTertiaryContainer:
          Color.lerp(onTertiaryContainer, other.onTertiaryContainer, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurfaceVariant:
          Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
    );
  }

  /// Correctly interpolates MaterialColor by lerping each shade individually
  MaterialColor _lerpMaterialColor(MaterialColor a, MaterialColor b, double t) {
    return MaterialColor(Color.lerp(a, b, t)!.value, {
      50: Color.lerp(a[50], b[50], t)!,
      100: Color.lerp(a[100], b[100], t)!,
      200: Color.lerp(a[200], b[200], t)!,
      300: Color.lerp(a[300], b[300], t)!,
      400: Color.lerp(a[400], b[400], t)!,
      500: Color.lerp(a[500], b[500], t)!,
      600: Color.lerp(a[600], b[600], t)!,
      700: Color.lerp(a[700], b[700], t)!,
      800: Color.lerp(a[800], b[800], t)!,
      900: Color.lerp(a[900], b[900], t)!,
    });
  }

  @override
  Object get type => AppColors;

  /// Default Light Theme Colors
  static AppColors get light => AppColors(
    white: const Color(0xFFFFFFFF),
    black: const Color(0xFF000000),
    transparent: Colors.transparent,
    brand: Colors.blue,
    grayLight: Colors.grey,
    grayDark: Colors.grey,
    warning: const Color(0xFFFFA726),
    error: const Color(0xFFEF5350),
    success: const Color(0xFF66BB6A),
    info: const Color(0xFF42A5F5),
    primary: const Color(0xFF6200EE),
    onPrimary: const Color(0xFFFFFFFF),
    primaryContainer: const Color(0xFFBB86FC),
    onPrimaryContainer: const Color(0xFF000000),
    secondary: const Color(0xFF03DAC6),
    onSecondary: const Color(0xFF000000),
    secondaryContainer: const Color(0xFF018786),
    onSecondaryContainer: const Color(0xFFFFFFFF),
    tertiary: const Color(0xFF03A9F4),
    onTertiary: const Color(0xFFFFFFFF),
    tertiaryContainer: const Color(0xFFB3E5FC),
    onTertiaryContainer: const Color(0xFF000000),
    surface: const Color(0xFFFFFFFF),
    onSurface: const Color(0xFF000000),
    surfaceVariant: const Color(0xFFF5F5F5),
    onSurfaceVariant: const Color(0xFF424242),
    background: const Color(0xFFFFFFFF),
    onBackground: const Color(0xFF000000),
    outline: const Color(0xFFBDBDBD),
    outlineVariant: const Color(0xFFE0E0E0),
    textPrimary: const Color(0xFF212121),
    textSecondary: const Color(0xFF757575),
    textDisabled: const Color(0xFFBDBDBD),
  );

  /// Default Dark Theme Colors
  static AppColors get dark => AppColors(
    white: const Color(0xFFFFFFFF),
    black: const Color(0xFF000000),
    transparent: Colors.transparent,
    brand: Colors.blue,
    grayLight: Colors.grey,
    grayDark: Colors.grey,
    warning: const Color(0xFFFFB74D),
    error: const Color(0xFFEF5350),
    success: const Color(0xFF81C784),
    info: const Color(0xFF64B5F6),
    primary: const Color(0xFFBB86FC),
    onPrimary: const Color(0xFF000000),
    primaryContainer: const Color(0xFF3700B3),
    onPrimaryContainer: const Color(0xFFFFFFFF),
    secondary: const Color(0xFF03DAC6),
    onSecondary: const Color(0xFF000000),
    secondaryContainer: const Color(0xFF005457),
    onSecondaryContainer: const Color(0xFFFFFFFF),
    tertiary: const Color(0xFF4FC3F7),
    onTertiary: const Color(0xFF000000),
    tertiaryContainer: const Color(0xFF01579B),
    onTertiaryContainer: const Color(0xFFFFFFFF),
    surface: const Color(0xFF1E1E1E),
    onSurface: const Color(0xFFE0E0E0),
    surfaceVariant: const Color(0xFF2C2C2C),
    onSurfaceVariant: const Color(0xFFBDBDBD),
    background: const Color(0xFF121212),
    onBackground: const Color(0xFFE0E0E0),
    outline: const Color(0xFF757575),
    outlineVariant: const Color(0xFF424242),
    textPrimary: const Color(0xFFE0E0E0),
    textSecondary: const Color(0xFFBDBDBD),
    textDisabled: const Color(0xFF757575),
  );
}
