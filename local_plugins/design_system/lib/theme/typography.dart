import 'package:flutter/material.dart';

/// Design tokens for typography
///
/// Provides consistent text styles throughout the application.
/// Includes font sizes, weights, line heights, and letter spacing.
///
/// Example:
/// ```dart
/// Text(
///   'Hello World',
///   style: TextStyle(
///     fontSize: AppTypography.fontSize.large,
///     fontWeight: AppTypography.fontWeight.bold,
///     height: AppTypography.lineHeight.normal,
///   ),
/// )
/// ```
class AppTypography {
  const AppTypography._();

  /// Font sizes in logical pixels
  static const fontSize = _FontSize._();

  /// Font weights (100-900)
  static const fontWeight = _FontWeight._();

  /// Line heights (as multipliers)
  static const lineHeight = _LineHeight._();

  /// Letter spacing values
  static const letterSpacing = _LetterSpacing._();
}

/// Font size tokens
class _FontSize {
  const _FontSize._();

  /// Extra small font size (10.0)
  final double xs = 10.0;

  /// Small font size (12.0)
  final double s = 12.0;

  /// Medium font size (14.0) - Body text
  final double m = 14.0;

  /// Large font size (16.0) - Default
  final double l = 16.0;

  /// Extra large font size (18.0)
  final double xl = 18.0;

  /// Extra extra large font size (20.0)
  final double xxl = 20.0;

  /// Heading 6 font size (24.0)
  final double h6 = 24.0;

  /// Heading 5 font size (28.0)
  final double h5 = 28.0;

  /// Heading 4 font size (32.0)
  final double h4 = 32.0;

  /// Heading 3 font size (36.0)
  final double h3 = 36.0;

  /// Heading 2 font size (40.0)
  final double h2 = 40.0;

  /// Heading 1 font size (48.0)
  final double h1 = 48.0;

  /// Display font size (56.0)
  final double display = 56.0;
}

/// Font weight tokens
class _FontWeight {
  const _FontWeight._();

  /// Thin weight (100)
  final FontWeight thin = FontWeight.w100;

  /// Extra light weight (200)
  final FontWeight extraLight = FontWeight.w200;

  /// Light weight (300)
  final FontWeight light = FontWeight.w300;

  /// Regular/Normal weight (400) - Default
  final FontWeight regular = FontWeight.w400;

  /// Medium weight (500)
  final FontWeight medium = FontWeight.w500;

  /// Semi bold weight (600)
  final FontWeight semiBold = FontWeight.w600;

  /// Bold weight (700)
  final FontWeight bold = FontWeight.w700;

  /// Extra bold weight (800)
  final FontWeight extraBold = FontWeight.w800;

  /// Black weight (900)
  final FontWeight black = FontWeight.w900;
}

/// Line height tokens (as multipliers of font size)
class _LineHeight {
  const _LineHeight._();

  /// Tight line height (1.2) - For headings
  final double tight = 1.2;

  /// Normal line height (1.5) - Default for body text
  final double normal = 1.5;

  /// Relaxed line height (1.75) - For better readability
  final double relaxed = 1.75;

  /// Loose line height (2.0) - For very spacious text
  final double loose = 2.0;
}

/// Letter spacing tokens
class _LetterSpacing {
  const _LetterSpacing._();

  /// Tight letter spacing (-0.5)
  final double tight = -0.5;

  /// Normal letter spacing (0.0) - Default
  final double normal = 0.0;

  /// Wide letter spacing (0.5)
  final double wide = 0.5;

  /// Extra wide letter spacing (1.0)
  final double extraWide = 1.0;

  /// Wider letter spacing (1.5) - For uppercase/small text
  final double wider = 1.5;
}

/// Pre-defined text styles following Material Design guidelines
///
/// Use these for common text patterns in your app.
///
/// Example:
/// ```dart
/// Text('Title', style: AppTextStyles.h1)
/// Text('Body', style: AppTextStyles.body)
/// ```
class AppTextStyles {
  AppTextStyles._();

  // Display styles
  static final TextStyle displayLarge = TextStyle(
    fontSize: AppTypography.fontSize.display,
    fontWeight: AppTypography.fontWeight.bold,
    height: AppTypography.lineHeight.tight,
    letterSpacing: AppTypography.letterSpacing.tight,
  );

  static final TextStyle displayMedium = TextStyle(
    fontSize: AppTypography.fontSize.h1,
    fontWeight: AppTypography.fontWeight.bold,
    height: AppTypography.lineHeight.tight,
    letterSpacing: AppTypography.letterSpacing.normal,
  );

  static final TextStyle displaySmall = TextStyle(
    fontSize: AppTypography.fontSize.h2,
    fontWeight: AppTypography.fontWeight.semiBold,
    height: AppTypography.lineHeight.tight,
    letterSpacing: AppTypography.letterSpacing.normal,
  );

  // Heading styles
  static final TextStyle h1 = TextStyle(
    fontSize: AppTypography.fontSize.h1,
    fontWeight: AppTypography.fontWeight.bold,
    height: AppTypography.lineHeight.tight,
  );

  static final TextStyle h2 = TextStyle(
    fontSize: AppTypography.fontSize.h2,
    fontWeight: AppTypography.fontWeight.bold,
    height: AppTypography.lineHeight.tight,
  );

  static final TextStyle h3 = TextStyle(
    fontSize: AppTypography.fontSize.h3,
    fontWeight: AppTypography.fontWeight.semiBold,
    height: AppTypography.lineHeight.tight,
  );

  static final TextStyle h4 = TextStyle(
    fontSize: AppTypography.fontSize.h4,
    fontWeight: AppTypography.fontWeight.semiBold,
    height: AppTypography.lineHeight.normal,
  );

  static final TextStyle h5 = TextStyle(
    fontSize: AppTypography.fontSize.h5,
    fontWeight: AppTypography.fontWeight.medium,
    height: AppTypography.lineHeight.normal,
  );

  static final TextStyle h6 = TextStyle(
    fontSize: AppTypography.fontSize.h6,
    fontWeight: AppTypography.fontWeight.medium,
    height: AppTypography.lineHeight.normal,
  );

  // Body styles
  static final TextStyle bodyLarge = TextStyle(
    fontSize: AppTypography.fontSize.l,
    fontWeight: AppTypography.fontWeight.regular,
    height: AppTypography.lineHeight.normal,
  );

  static final TextStyle body = TextStyle(
    fontSize: AppTypography.fontSize.m,
    fontWeight: AppTypography.fontWeight.regular,
    height: AppTypography.lineHeight.normal,
  );

  static final TextStyle bodySmall = TextStyle(
    fontSize: AppTypography.fontSize.s,
    fontWeight: AppTypography.fontWeight.regular,
    height: AppTypography.lineHeight.normal,
  );

  // Label styles
  static final TextStyle labelLarge = TextStyle(
    fontSize: AppTypography.fontSize.m,
    fontWeight: AppTypography.fontWeight.medium,
    height: AppTypography.lineHeight.normal,
    letterSpacing: AppTypography.letterSpacing.wide,
  );

  static final TextStyle label = TextStyle(
    fontSize: AppTypography.fontSize.s,
    fontWeight: AppTypography.fontWeight.medium,
    height: AppTypography.lineHeight.normal,
    letterSpacing: AppTypography.letterSpacing.wide,
  );

  static final TextStyle labelSmall = TextStyle(
    fontSize: AppTypography.fontSize.xs,
    fontWeight: AppTypography.fontWeight.medium,
    height: AppTypography.lineHeight.normal,
    letterSpacing: AppTypography.letterSpacing.wider,
  );

  // Button styles
  static final TextStyle button = TextStyle(
    fontSize: AppTypography.fontSize.m,
    fontWeight: AppTypography.fontWeight.medium,
    height: AppTypography.lineHeight.normal,
    letterSpacing: AppTypography.letterSpacing.wide,
  );

  static final TextStyle buttonLarge = TextStyle(
    fontSize: AppTypography.fontSize.l,
    fontWeight: AppTypography.fontWeight.medium,
    height: AppTypography.lineHeight.normal,
    letterSpacing: AppTypography.letterSpacing.wide,
  );

  static final TextStyle buttonSmall = TextStyle(
    fontSize: AppTypography.fontSize.s,
    fontWeight: AppTypography.fontWeight.medium,
    height: AppTypography.lineHeight.normal,
    letterSpacing: AppTypography.letterSpacing.wider,
  );

  // Caption/Helper styles
  static final TextStyle caption = TextStyle(
    fontSize: AppTypography.fontSize.s,
    fontWeight: AppTypography.fontWeight.regular,
    height: AppTypography.lineHeight.normal,
  );

  static final TextStyle overline = TextStyle(
    fontSize: AppTypography.fontSize.xs,
    fontWeight: AppTypography.fontWeight.medium,
    height: AppTypography.lineHeight.normal,
    letterSpacing: AppTypography.letterSpacing.wider,
  );
}
