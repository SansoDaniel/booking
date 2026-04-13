import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system/design_system.dart';

void main() {
  group('AppColors', () {
    test('should create AppColors instance with all required properties', () {
      final colors = AppColors(
        white: Colors.white,
        black: Colors.black,
        transparent: Colors.transparent,
        brand: Colors.blue,
        grayLight: Colors.grey,
        grayDark: Colors.grey,
        error: Colors.red,
        warning: Colors.orange,
        success: Colors.green,
        info: Colors.blue,
        primary: Colors.blue,
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

      expect(colors.white, Colors.white);
      expect(colors.black, Colors.black);
      expect(colors.primary, Colors.blue);
      expect(colors.error, Colors.red);
    });

    test('copyWith should create new instance with updated properties', () {
      final colors = AppColors(
        white: Colors.white,
        black: Colors.black,
        transparent: Colors.transparent,
        brand: Colors.blue,
        grayLight: Colors.grey,
        grayDark: Colors.grey,
        error: Colors.red,
        warning: Colors.orange,
        success: Colors.green,
        info: Colors.blue,
        primary: Colors.blue,
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

      final updatedColors = colors.copyWith(primary: Colors.green) as AppColors;

      expect(updatedColors.primary, Colors.green);
      expect(updatedColors.error, Colors.red); // Should remain unchanged
    });

    test('lerp should interpolate colors correctly', () {
      final colors1 = AppColors(
        white: Colors.white,
        black: Colors.black,
        transparent: Colors.transparent,
        brand: Colors.blue,
        grayLight: Colors.grey,
        grayDark: Colors.grey,
        error: Colors.red,
        warning: Colors.orange,
        success: Colors.green,
        info: Colors.blue,
        primary: Colors.blue,
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

      final colors2 = colors1.copyWith(primary: Colors.green);
      final interpolated = colors1.lerp(colors2, 0.5) as AppColors;

      // The interpolated color should be between blue and green
      expect(interpolated.primary, isNot(Colors.blue));
      expect(interpolated.primary, isNot(Colors.green));
    });

    test('type getter should return AppColors type', () {
      final colors = AppColors(
        white: Colors.white,
        black: Colors.black,
        transparent: Colors.transparent,
        brand: Colors.blue,
        grayLight: Colors.grey,
        grayDark: Colors.grey,
        error: Colors.red,
        warning: Colors.orange,
        success: Colors.green,
        info: Colors.blue,
        primary: Colors.blue,
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

      expect(colors.type, AppColors);
    });
  });
}
