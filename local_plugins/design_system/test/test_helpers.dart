import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system/design_system.dart';

/// Test helper utilities for design system testing
class DesignSystemTestHelpers {
  const DesignSystemTestHelpers._();

  /// Creates a MaterialApp wrapper for widget testing
  ///
  /// Example:
  /// ```dart
  /// await tester.pumpWidget(
  ///   DesignSystemTestHelpers.wrapWidget(MyWidget()),
  /// );
  /// ```
  static Widget wrapWidget(
    Widget child, {
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode themeMode = ThemeMode.light,
    NavigatorObserver? navigatorObserver,
  }) {
    return MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: Scaffold(body: child),
      navigatorObservers: navigatorObserver != null ? [navigatorObserver] : [],
    );
  }

  /// Creates a basic test AppColors instance
  static AppColors createTestColors({
    Color? primary,
    Color? error,
    Color? success,
  }) {
    return AppColors(
      white: Colors.white,
      black: Colors.black,
      transparent: Colors.transparent,
      brand: Colors.blue,
      grayLight: Colors.grey,
      grayDark: Colors.grey,
      error: error ?? Colors.red,
      warning: Colors.orange,
      success: success ?? Colors.green,
      info: Colors.blue,
      primary: primary ?? Colors.blue,
      onPrimary: Colors.white,
      primaryContainer: Colors.blue.shade100,
      onPrimaryContainer: Colors.blue.shade900,
      secondary: Colors.purple,
      onSecondary: Colors.white,
      secondaryContainer: Colors.purple.shade100,
      onSecondaryContainer: Colors.purple.shade900,
      tertiary: Colors.teal,
      onTertiary: Colors.white,
      tertiaryContainer: Colors.teal.shade100,
      onTertiaryContainer: Colors.teal.shade900,
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceVariant: Colors.grey.shade100,
      onSurfaceVariant: Colors.grey.shade900,
      background: Colors.white,
      onBackground: Colors.black,
      outline: Colors.grey,
      outlineVariant: Colors.grey.shade300,
      textPrimary: Colors.black,
      textSecondary: Colors.grey,
      textDisabled: Colors.grey.shade400,
    );
  }

  /// Creates a test theme with custom colors
  static ThemeData createTestTheme({
    Brightness brightness = Brightness.light,
    AppColors? colors,
  }) {
    final baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      extensions: [
        colors ?? createTestColors(),
      ],
    );
  }

  /// Pumps a widget and waits for all animations to complete
  static Future<void> pumpAndSettleWidget(
    WidgetTester tester,
    Widget widget, {
    Duration? duration,
  }) async {
    await tester.pumpWidget(widget);
    if (duration != null) {
      await tester.pumpAndSettle(duration);
    } else {
      await tester.pumpAndSettle();
    }
  }

  /// Simulates a tap and waits for animations
  static Future<void> tapAndSettle(
    WidgetTester tester,
    Finder finder,
  ) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  /// Simulates a long press and waits for animations
  static Future<void> longPressAndSettle(
    WidgetTester tester,
    Finder finder,
  ) async {
    await tester.longPress(finder);
    await tester.pumpAndSettle();
  }

  /// Verifies that a widget has the expected accessibility label
  static void verifyAccessibilityLabel(
    WidgetTester tester,
    Finder finder,
    String expectedLabel,
  ) {
    final widget = tester.widget(finder);
    if (widget is Semantics) {
      expect(
        widget.properties.label,
        expectedLabel,
        reason: 'Widget should have correct accessibility label',
      );
    }
  }

  /// Verifies that spacing values are consistent
  static void verifySpacingConsistency() {
    expect(AppSpacing.xxs < AppSpacing.xs, isTrue);
    expect(AppSpacing.xs < AppSpacing.s, isTrue);
    expect(AppSpacing.s < AppSpacing.sm, isTrue);
    expect(AppSpacing.sm < AppSpacing.m, isTrue);
    expect(AppSpacing.m < AppSpacing.l, isTrue);
    expect(AppSpacing.l < AppSpacing.xl, isTrue);
    expect(AppSpacing.xl < AppSpacing.xxl, isTrue);
  }

  /// Verifies that radius values are consistent
  static void verifyRadiusConsistency() {
    expect(AppRadius.xxs.x < AppRadius.xs.x, isTrue);
    expect(AppRadius.xs.x < AppRadius.s.x, isTrue);
    expect(AppRadius.s.x < AppRadius.m.x, isTrue);
    expect(AppRadius.m.x < AppRadius.l.x, isTrue);
    expect(AppRadius.l.x < AppRadius.xl.x, isTrue);
    expect(AppRadius.xl.x < AppRadius.xxl.x, isTrue);
  }

  /// Creates a FocusNode for testing focus behavior
  static FocusNode createTestFocusNode({
    bool requestFocus = false,
  }) {
    final node = FocusNode();
    if (requestFocus) {
      node.requestFocus();
    }
    return node;
  }

  /// Disposes multiple FocusNodes
  static void disposeFocusNodes(List<FocusNode> nodes) {
    for (final node in nodes) {
      node.dispose();
    }
  }
}

/// Custom matchers for design system testing
class DesignSystemMatchers {
  const DesignSystemMatchers._();

  /// Matcher for checking if a color is valid (not null and has valid RGB values)
  static Matcher isValidColor() {
    return predicate<Color>(
      (color) => color.alpha >= 0 && color.alpha <= 255 &&
                 color.red >= 0 && color.red <= 255 &&
                 color.green >= 0 && color.green <= 255 &&
                 color.blue >= 0 && color.blue <= 255,
      'is a valid color with RGB values between 0-255',
    );
  }

  /// Matcher for checking if a duration is within a reasonable range
  static Matcher isReasonableDuration({
    int minMs = 0,
    int maxMs = 1000,
  }) {
    return predicate<Duration>(
      (duration) => duration.inMilliseconds >= minMs &&
                     duration.inMilliseconds <= maxMs,
      'is a duration between $minMs and $maxMs milliseconds',
    );
  }

  /// Matcher for checking if a value is a positive number
  static Matcher isPositiveNumber() {
    return predicate<num>(
      (value) => value > 0,
      'is a positive number',
    );
  }

  /// Matcher for checking if spacing is from design tokens
  static Matcher isDesignTokenSpacing() {
    return anyOf([
      equals(AppSpacing.none),
      equals(AppSpacing.xxs),
      equals(AppSpacing.xs),
      equals(AppSpacing.s),
      equals(AppSpacing.sm),
      equals(AppSpacing.m),
      equals(AppSpacing.l),
      equals(AppSpacing.xl),
      equals(AppSpacing.xxl),
    ]);
  }

  /// Matcher for checking if radius is from design tokens
  static Matcher isDesignTokenRadius() {
    return anyOf([
      equals(AppRadius.none),
      equals(AppRadius.xxs),
      equals(AppRadius.xs),
      equals(AppRadius.s),
      equals(AppRadius.m),
      equals(AppRadius.l),
      equals(AppRadius.xl),
      equals(AppRadius.xxl),
    ]);
  }
}

/// Extension methods for easier testing
extension WidgetTesterExtensions on WidgetTester {
  /// Pumps widget with design system theme
  Future<void> pumpWidgetWithTheme(
    Widget widget, {
    Brightness brightness = Brightness.light,
  }) async {
    await pumpWidget(
      MaterialApp(
        theme: DesignSystemTestHelpers.createTestTheme(brightness: brightness),
        home: Scaffold(body: widget),
      ),
    );
  }

  /// Finds widget by type and verifies it exists
  Finder findAndVerify<T extends Widget>() {
    final finder = find.byType(T);
    expect(finder, findsOneWidget);
    return finder;
  }

  /// Taps a widget by type and waits for animations
  Future<void> tapByTypeAndSettle<T extends Widget>() async {
    final finder = find.byType(T);
    await tap(finder);
    await pumpAndSettle();
  }
}
