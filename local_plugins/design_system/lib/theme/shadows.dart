import 'package:flutter/material.dart';

/// Design tokens for shadows and elevation
///
/// Provides consistent shadow effects following Material Design elevation system.
/// Use these for consistent depth hierarchy throughout the application.
///
/// Example:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     boxShadow: AppShadows.medium,
///     borderRadius: BorderRadius.circular(8),
///   ),
///   child: Text('Card with shadow'),
/// )
/// ```
class AppShadows {
  const AppShadows._();

  /// No shadow (elevation 0)
  static const List<BoxShadow> none = [];

  /// Extra small shadow (elevation 1)
  /// Subtle shadow for slightly raised elements
  static const List<BoxShadow> xs = [
    BoxShadow(
      color: Color(0x0A000000), // 4% opacity black
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  /// Small shadow (elevation 2)
  /// For buttons, chips, cards at rest
  static const List<BoxShadow> s = [
    BoxShadow(
      color: Color(0x14000000), // 8% opacity black
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A000000), // 4% opacity black
      offset: Offset(0, 2),
      blurRadius: 2,
      spreadRadius: -1,
    ),
  ];

  /// Medium shadow (elevation 4)
  /// For raised buttons, cards on hover
  static const List<BoxShadow> m = [
    BoxShadow(
      color: Color(0x14000000), // 8% opacity black
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A000000), // 4% opacity black
      offset: Offset(0, 4),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  /// Large shadow (elevation 8)
  /// For dropdowns, menus, dialogs
  static const List<BoxShadow> l = [
    BoxShadow(
      color: Color(0x1F000000), // 12% opacity black
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x14000000), // 8% opacity black
      offset: Offset(0, 6),
      blurRadius: 8,
      spreadRadius: -2,
    ),
  ];

  /// Extra large shadow (elevation 16)
  /// For modal dialogs, drawers
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x24000000), // 14% opacity black
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x1F000000), // 12% opacity black
      offset: Offset(0, 12),
      blurRadius: 16,
      spreadRadius: -4,
    ),
  ];

  /// Extra extra large shadow (elevation 24)
  /// For bottom sheets, navigation drawers
  static const List<BoxShadow> xxl = [
    BoxShadow(
      color: Color(0x29000000), // 16% opacity black
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x24000000), // 14% opacity black
      offset: Offset(0, 16),
      blurRadius: 24,
      spreadRadius: -6,
    ),
  ];
}

/// Elevation levels following Material Design specification
///
/// Use these values with Material widget's elevation property.
///
/// Example:
/// ```dart
/// Card(
///   elevation: AppElevation.medium,
///   child: Text('Elevated card'),
/// )
/// ```
class AppElevation {
  const AppElevation._();

  /// No elevation (0.0)
  static const double none = 0.0;

  /// Extra small elevation (1.0)
  /// For slightly raised elements
  static const double xs = 1.0;

  /// Small elevation (2.0)
  /// For buttons, chips, cards at rest
  static const double s = 2.0;

  /// Medium elevation (4.0)
  /// For raised buttons, cards on hover
  static const double m = 4.0;

  /// Large elevation (8.0)
  /// For dropdowns, menus, search bars
  static const double l = 8.0;

  /// Extra large elevation (16.0)
  /// For modal dialogs, pickers
  static const double xl = 16.0;

  /// Extra extra large elevation (24.0)
  /// For bottom sheets, navigation drawers
  static const double xxl = 24.0;
}

/// Inner shadow effect (inset shadow)
///
/// Flutter doesn't support inset shadows natively in BoxShadow.
/// Use this with custom painters or Stack/positioned widgets.
///
/// Example with Container inner border:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     color: Colors.white,
///     border: Border.all(
///       color: AppInnerShadow.light.color,
///       width: AppInnerShadow.light.width,
///     ),
///   ),
/// )
/// ```
class AppInnerShadow {
  final Color color;
  final double width;
  final double blur;

  const AppInnerShadow._({
    required this.color,
    required this.width,
    required this.blur,
  });

  /// Light inner shadow
  static const light = AppInnerShadow._(
    color: Color(0x0F000000), // 6% opacity black
    width: 1.0,
    blur: 2.0,
  );

  /// Medium inner shadow
  static const medium = AppInnerShadow._(
    color: Color(0x1A000000), // 10% opacity black
    width: 1.5,
    blur: 3.0,
  );

  /// Dark inner shadow
  static const dark = AppInnerShadow._(
    color: Color(0x29000000), // 16% opacity black
    width: 2.0,
    blur: 4.0,
  );
}
