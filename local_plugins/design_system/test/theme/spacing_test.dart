import 'package:flutter_test/flutter_test.dart';
import 'package:design_system/design_system.dart';

void main() {
  group('AppSpacing', () {
    test('should have correct spacing values', () {
      expect(AppSpacing.none, 0.0);
      expect(AppSpacing.xxs, 2.0);
      expect(AppSpacing.xs, 4.0);
      expect(AppSpacing.s, 8.0);
      expect(AppSpacing.sm, 10.0);
      expect(AppSpacing.m, 12.0);
      expect(AppSpacing.l, 16.0);
      expect(AppSpacing.xl, 20.0);
      expect(AppSpacing.xxl, 24.0);
    });

    test('spacing values should be compile-time constants', () {
      const spacing = AppSpacing.m;
      expect(spacing, 12.0);
    });

    test('spacing values should be in ascending order', () {
      expect(AppSpacing.xxs < AppSpacing.xs, isTrue);
      expect(AppSpacing.xs < AppSpacing.s, isTrue);
      expect(AppSpacing.s < AppSpacing.sm, isTrue);
      expect(AppSpacing.sm < AppSpacing.m, isTrue);
      expect(AppSpacing.m < AppSpacing.l, isTrue);
      expect(AppSpacing.l < AppSpacing.xl, isTrue);
      expect(AppSpacing.xl < AppSpacing.xxl, isTrue);
    });
  });
}
