import 'package:flutter/material.dart';

/// Design tokens for border radius values
///
/// Provides consistent border radius throughout the application.
/// Use these constants for rounded corners on containers, cards, buttons, etc.
///
/// Example:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.all(AppRadius.m),
///   ),
///   child: Text('Hello'),
/// )
/// ```
class AppRadius {
  const AppRadius._();

  /// No radius (sharp corners)
  static const Radius none = Radius.zero;

  /// Extra extra small radius (2.0)
  static const Radius xxs = Radius.circular(2);

  /// Extra small radius (4.0)
  static const Radius xs = Radius.circular(4);

  /// Small radius (8.0)
  static const Radius s = Radius.circular(8);

  /// Medium radius (12.0)
  static const Radius m = Radius.circular(12);

  /// Large radius (16.0)
  static const Radius l = Radius.circular(16);

  /// Extra large radius (20.0)
  static const Radius xl = Radius.circular(20);

  /// Extra extra large radius (24.0)
  static const Radius xxl = Radius.circular(24);
}
