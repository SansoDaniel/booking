import 'package:flutter/material.dart';

/// Design tokens for responsive breakpoints
///
/// Provides consistent breakpoints for responsive layouts following common
/// device sizes and Material Design guidelines.
///
/// Use these to create adaptive layouts that work across different screen sizes.
///
/// Example:
/// ```dart
/// LayoutBuilder(
///   builder: (context, constraints) {
///     if (constraints.maxWidth >= AppBreakpoints.desktop) {
///       return DesktopLayout();
///     } else if (constraints.maxWidth >= AppBreakpoints.tablet) {
///       return TabletLayout();
///     } else {
///       return MobileLayout();
///     }
///   },
/// )
/// ```
class AppBreakpoints {
  const AppBreakpoints._();

  /// Extra small devices (portrait phones, less than 576px)
  static const double xs = 0;

  /// Small devices (landscape phones, 576px and up)
  static const double sm = 576;

  /// Medium devices (tablets, 768px and up)
  static const double md = 768;

  /// Large devices (desktops, 992px and up)
  static const double lg = 992;

  /// Extra large devices (large desktops, 1200px and up)
  static const double xl = 1200;

  /// Extra extra large devices (larger desktops, 1400px and up)
  static const double xxl = 1400;

  // Semantic aliases for common device types
  /// Mobile device breakpoint (same as xs)
  static const double mobile = xs;

  /// Tablet device breakpoint (same as md)
  static const double tablet = md;

  /// Desktop device breakpoint (same as lg)
  static const double desktop = lg;

  /// Large desktop breakpoint (same as xl)
  static const double largeDesktop = xl;
}

/// Extension methods for BuildContext to easily check breakpoints
extension BreakpointExtension on BuildContext {
  /// Get the current screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get the current screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if the current screen is extra small (mobile portrait)
  bool get isXs => screenWidth < AppBreakpoints.sm;

  /// Check if the current screen is small (mobile landscape)
  bool get isSm => screenWidth >= AppBreakpoints.sm && screenWidth < AppBreakpoints.md;

  /// Check if the current screen is medium (tablet)
  bool get isMd => screenWidth >= AppBreakpoints.md && screenWidth < AppBreakpoints.lg;

  /// Check if the current screen is large (desktop)
  bool get isLg => screenWidth >= AppBreakpoints.lg && screenWidth < AppBreakpoints.xl;

  /// Check if the current screen is extra large (large desktop)
  bool get isXl => screenWidth >= AppBreakpoints.xl && screenWidth < AppBreakpoints.xxl;

  /// Check if the current screen is extra extra large (larger desktop)
  bool get isXxl => screenWidth >= AppBreakpoints.xxl;

  // Semantic aliases
  /// Check if current device is mobile (xs or sm)
  bool get isMobile => screenWidth < AppBreakpoints.md;

  /// Check if current device is tablet (md)
  bool get isTablet => isMd;

  /// Check if current device is desktop (lg or above)
  bool get isDesktop => screenWidth >= AppBreakpoints.lg;

  /// Check if current device is large desktop (xl or above)
  bool get isLargeDesktop => screenWidth >= AppBreakpoints.xl;

  /// Get the current breakpoint name
  String get breakpointName {
    if (isXxl) return 'xxl';
    if (isXl) return 'xl';
    if (isLg) return 'lg';
    if (isMd) return 'md';
    if (isSm) return 'sm';
    return 'xs';
  }

  /// Get responsive value based on current breakpoint
  ///
  /// Example:
  /// ```dart
  /// final padding = context.responsive(
  ///   xs: 8.0,
  ///   sm: 12.0,
  ///   md: 16.0,
  ///   lg: 20.0,
  ///   xl: 24.0,
  /// );
  /// ```
  T responsive<T>({
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
  }) {
    if (isXxl && xxl != null) return xxl;
    if (isXl && xl != null) return xl;
    if (isLg && lg != null) return lg;
    if (isMd && md != null) return md;
    if (isSm && sm != null) return sm;
    return xs;
  }
}

/// Helper widget for responsive layouts
///
/// Simplifies building responsive UIs by providing builder functions
/// for different screen sizes.
///
/// Example:
/// ```dart
/// ResponsiveBuilder(
///   mobile: (context) => MobileLayout(),
///   tablet: (context) => TabletLayout(),
///   desktop: (context) => DesktopLayout(),
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  /// Creates a responsive builder widget.
  ///
  /// The [mobile] builder is required and will be used as fallback.
  /// [tablet] and [desktop] are optional.
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Builder for mobile devices (< 768px)
  final WidgetBuilder mobile;

  /// Builder for tablet devices (768px - 991px)
  final WidgetBuilder? tablet;

  /// Builder for desktop devices (>= 992px)
  final WidgetBuilder? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppBreakpoints.desktop && desktop != null) {
          return desktop!(context);
        } else if (constraints.maxWidth >= AppBreakpoints.tablet && tablet != null) {
          return tablet!(context);
        } else {
          return mobile(context);
        }
      },
    );
  }
}

/// Advanced responsive builder with more granular control
///
/// Provides builders for all breakpoint sizes with fallback logic.
///
/// Example:
/// ```dart
/// ResponsiveBuilderAdvanced(
///   xs: (context) => ExtraSmallLayout(),
///   sm: (context) => SmallLayout(),
///   md: (context) => MediumLayout(),
///   lg: (context) => LargeLayout(),
///   xl: (context) => ExtraLargeLayout(),
///   xxl: (context) => ExtraExtraLargeLayout(),
/// )
/// ```
class ResponsiveBuilderAdvanced extends StatelessWidget {
  /// Creates an advanced responsive builder widget.
  ///
  /// At least one builder must be provided. If a specific breakpoint builder
  /// is not provided, it will fall back to the next smaller breakpoint.
  const ResponsiveBuilderAdvanced({
    super.key,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  }) : assert(
          xs != null || sm != null || md != null || lg != null || xl != null || xxl != null,
          'At least one builder must be provided',
        );

  final WidgetBuilder? xs;
  final WidgetBuilder? sm;
  final WidgetBuilder? md;
  final WidgetBuilder? lg;
  final WidgetBuilder? xl;
  final WidgetBuilder? xxl;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Check from largest to smallest with fallback logic
        if (width >= AppBreakpoints.xxl) {
          return (xxl ?? xl ?? lg ?? md ?? sm ?? xs)!(context);
        } else if (width >= AppBreakpoints.xl) {
          return (xl ?? lg ?? md ?? sm ?? xs)!(context);
        } else if (width >= AppBreakpoints.lg) {
          return (lg ?? md ?? sm ?? xs)!(context);
        } else if (width >= AppBreakpoints.md) {
          return (md ?? sm ?? xs)!(context);
        } else if (width >= AppBreakpoints.sm) {
          return (sm ?? xs)!(context);
        } else {
          return xs!(context);
        }
      },
    );
  }
}

/// Responsive value helper
///
/// Returns different values based on screen size.
///
/// Example:
/// ```dart
/// final padding = ResponsiveValue<double>(
///   context: context,
///   xs: 8.0,
///   sm: 12.0,
///   md: 16.0,
///   lg: 20.0,
///   xl: 24.0,
/// ).value;
/// ```
class ResponsiveValue<T> {
  /// Creates a responsive value helper.
  ///
  /// The [xs] value is required and will be used as fallback.
  ResponsiveValue({
    required this.context,
    required this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  });

  final BuildContext context;
  final T xs;
  final T? sm;
  final T? md;
  final T? lg;
  final T? xl;
  final T? xxl;

  /// Get the value for the current screen size
  T get value {
    final width = MediaQuery.of(context).size.width;

    if (width >= AppBreakpoints.xxl && xxl != null) return xxl!;
    if (width >= AppBreakpoints.xl && xl != null) return xl!;
    if (width >= AppBreakpoints.lg && lg != null) return lg!;
    if (width >= AppBreakpoints.md && md != null) return md!;
    if (width >= AppBreakpoints.sm && sm != null) return sm!;
    return xs;
  }
}
