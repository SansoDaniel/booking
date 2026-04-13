import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/radius.dart';
import '../../theme/spacing.dart';

/// Model class for testing KeyBoardAccessibility widget.
///
/// Create model classes like this when a widget needs to be tested,
/// especially if the widget requires multiple properties to be verified.
///
/// Example:
/// ```dart
/// testWidgets('KeyBoardAccessibility shows focus border', (tester) async {
///   final model = KeyBoardAccessibilityModel(
///     hasFocus: true,
///     borderColor: Colors.blue,
///   );
///   // ... test implementation
/// });
/// ```
class KeyBoardAccessibilityModel {
  final bool hasFocus;
  final Color? borderColor;
  final double? borderWidth;
  final double? padding;
  final Radius? borderRadius;

  const KeyBoardAccessibilityModel({
    this.hasFocus = false,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.borderRadius,
  });
}

/// Adds a focus indicator border with padding to ensure visual accessibility.
///
/// This widget wraps child widgets to provide visual feedback when they receive
/// keyboard focus, improving accessibility for keyboard navigation users.
///
/// The focus indicator automatically adapts to the current theme (light/dark mode)
/// and uses design tokens for consistent styling.
///
/// Features:
/// - Animated focus transitions for smooth visual feedback
/// - Theme-aware default colors (respects light/dark mode)
/// - Configurable border color, width, padding, and radius
/// - Uses design system tokens for consistency
///
/// Example:
/// ```dart
/// KeyBoardAccessibility(
///   child: TextButton(
///     onPressed: () {},
///     child: Text('Click me'),
///   ),
/// )
/// ```
///
/// Custom styling example:
/// ```dart
/// KeyBoardAccessibility(
///   focusBorderColor: Colors.blue,
///   focusBorderWidth: 3.0,
///   focusPadding: 8.0,
///   focusBorderRadius: AppRadius.m,
///   child: MyWidget(),
/// )
/// ```
class KeyBoardAccessibility extends StatefulWidget {
  /// Creates a keyboard accessibility wrapper.
  ///
  /// The [child] parameter is required and will be wrapped with focus indicators.
  const KeyBoardAccessibility({
    super.key,
    required this.child,
    this.focusBorderColor,
    this.focusBorderWidth = 2.0,
    this.focusPadding,
    this.focusBorderRadius,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  /// The widget to wrap with focus indicators.
  final Widget child;

  /// Color of the focus border.
  ///
  /// If null, defaults to theme-aware color:
  /// - Light mode: Colors.black54
  /// - Dark mode: Colors.white70
  final Color? focusBorderColor;

  /// Width of the focus border.
  ///
  /// Defaults to 2.0 logical pixels.
  final double focusBorderWidth;

  /// Padding around the child when focused.
  ///
  /// If null, defaults to [AppSpacing.xs] (4.0).
  final double? focusPadding;

  /// Border radius for the focus indicator.
  ///
  /// If null, defaults to [AppRadius.xs] (4.0).
  final Radius? focusBorderRadius;

  /// Duration of the focus transition animation.
  ///
  /// Defaults to 200 milliseconds.
  final Duration animationDuration;

  @override
  State<KeyBoardAccessibility> createState() => _KeyBoardAccessibilityState();
}

class _KeyBoardAccessibilityState extends State<KeyBoardAccessibility> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Get theme-aware default border color
    final borderColor = widget.focusBorderColor ??
        (isDarkMode ? Colors.white70 : Colors.black54);

    // Use design tokens for padding and radius
    final padding = widget.focusPadding ?? AppSpacing.xs;
    final borderRadius = widget.focusBorderRadius ?? AppRadius.xs;

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _hasFocus = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: Curves.easeInOut,
        padding: _hasFocus ? EdgeInsets.all(padding) : EdgeInsets.zero,
        decoration: _hasFocus
            ? BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: widget.focusBorderWidth,
                ),
                borderRadius: BorderRadius.all(borderRadius),
              )
            : null,
        child: widget.child,
      ),
    );
  }
}
