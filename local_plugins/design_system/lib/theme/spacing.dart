/// Design tokens for spacing values
///
/// Provides consistent spacing throughout the application.
/// Use these constants instead of hardcoded values for better maintainability.
///
/// Example:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(AppSpacing.m),
///   child: Text('Hello'),
/// )
/// ```
class AppSpacing {
  const AppSpacing._();

  /// No spacing (0.0)
  static const double none = 0.0;

  /// Extra extra small spacing (2.0)
  static const double xxs = 2.0;

  /// Extra small spacing (4.0)
  static const double xs = 4.0;

  /// Small spacing (8.0)
  static const double s = 8.0;

  /// Small-medium spacing (10.0)
  static const double sm = 10.0;

  /// Medium spacing (12.0)
  static const double m = 12.0;

  /// Large spacing (16.0)
  static const double l = 16.0;

  /// Extra large spacing (20.0)
  static const double xl = 20.0;

  /// Extra extra large spacing (24.0)
  static const double xxl = 24.0;
}
