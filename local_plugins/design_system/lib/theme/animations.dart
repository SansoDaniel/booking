import 'package:flutter/material.dart';

/// Design tokens for animation durations and curves
///
/// Provides consistent animation timing and easing throughout the application
/// following Material Design motion guidelines.
///
/// Use these constants for consistent and predictable animations.
///
/// Example:
/// ```dart
/// AnimatedContainer(
///   duration: AppAnimations.duration.medium,
///   curve: AppAnimations.curve.easeInOut,
///   child: MyWidget(),
/// )
/// ```
class AppAnimations {
  const AppAnimations._();

  /// Animation durations
  static const duration = _AnimationDuration._();

  /// Animation curves (easing functions)
  static const curve = _AnimationCurve._();
}

/// Animation duration tokens in milliseconds
///
/// Use these for consistent timing across all animations.
class _AnimationDuration {
  const _AnimationDuration._();

  /// Instant transition (0ms) - No animation
  final Duration instant = Duration.zero;

  /// Very fast animation (75ms) - Micro-interactions
  /// Use for: Ripple effects, hover states
  final Duration veryFast = const Duration(milliseconds: 75);

  /// Fast animation (150ms) - Quick transitions
  /// Use for: Icon changes, button states, simple property changes
  final Duration fast = const Duration(milliseconds: 150);

  /// Normal animation (200ms) - Default speed
  /// Use for: Most UI transitions, widget appearances/disappearances
  final Duration normal = const Duration(milliseconds: 200);

  /// Medium animation (300ms) - Comfortable speed
  /// Use for: Sheet/dialog entrances, page transitions
  final Duration medium = const Duration(milliseconds: 300);

  /// Slow animation (400ms) - Deliberate motion
  /// Use for: Complex transitions, attention-grabbing animations
  final Duration slow = const Duration(milliseconds: 400);

  /// Very slow animation (500ms) - Emphasized motion
  /// Use for: Page transitions with multiple elements
  final Duration verySlow = const Duration(milliseconds: 500);

  /// Extra slow animation (700ms) - Extended motion
  /// Use for: Complex choreographed animations
  final Duration extraSlow = const Duration(milliseconds: 700);

  /// Duration for snackbar animations (250ms)
  final Duration snackbar = const Duration(milliseconds: 250);

  /// Duration for navigation bar transitions (250ms)
  final Duration navigationBar = const Duration(milliseconds: 250);
}

/// Animation curve tokens (easing functions)
///
/// Use these for natural and polished motion.
class _AnimationCurve {
  const _AnimationCurve._();

  // Standard Material curves
  /// Linear motion (no easing)
  final Curve linear = Curves.linear;

  /// Ease motion (gentle acceleration and deceleration)
  final Curve ease = Curves.ease;

  /// Ease in (gradual acceleration)
  final Curve easeIn = Curves.easeIn;

  /// Ease out (gradual deceleration)
  final Curve easeOut = Curves.easeOut;

  /// Ease in and out (symmetric acceleration/deceleration)
  final Curve easeInOut = Curves.easeInOut;

  // Material emphasized curves
  /// Standard curve - Default for most animations
  /// Quick acceleration, gradual deceleration
  final Curve standard = Curves.easeInOut;

  /// Emphasized curve - For important/attention-grabbing animations
  /// Sharp acceleration, longer deceleration
  final Curve emphasized = Curves.easeOutCubic;

  /// Decelerated curve - For entering elements
  /// Elements that enter the screen
  final Curve decelerate = Curves.easeOut;

  /// Accelerated curve - For exiting elements
  /// Elements that leave the screen
  final Curve accelerate = Curves.easeIn;

  // Advanced curves
  /// Fast out, slow in - Material motion standard
  final Curve fastOutSlowIn = Curves.fastOutSlowIn;

  /// Linear out, slow in - For incoming elements
  final Curve linearToEaseOut = Curves.linearToEaseOut;

  /// Fast out, linear in - For outgoing elements
  final Curve fastLinearToSlowEaseIn = Curves.fastLinearToSlowEaseIn;

  /// Bounce effect
  final Curve bounce = Curves.bounceOut;

  /// Elastic effect
  final Curve elastic = Curves.elasticOut;
}

/// Pre-configured animation settings for common UI patterns
///
/// Combines duration and curve for specific animation types.
///
/// Example:
/// ```dart
/// AnimatedContainer(
///   duration: AppAnimationPresets.button.duration,
///   curve: AppAnimationPresets.button.curve,
///   child: MyButton(),
/// )
/// ```
class AppAnimationPresets {
  const AppAnimationPresets._();

  /// Button animation preset
  static final button = AnimationConfig(
    duration: AppAnimations.duration.fast,
    curve: AppAnimations.curve.standard,
  );

  /// Dialog/Modal animation preset
  static final dialog = AnimationConfig(
    duration: AppAnimations.duration.medium,
    curve: AppAnimations.curve.emphasized,
  );

  /// Page transition animation preset
  static final pageTransition = AnimationConfig(
    duration: AppAnimations.duration.slow,
    curve: AppAnimations.curve.emphasized,
  );

  /// Drawer animation preset
  static final drawer = AnimationConfig(
    duration: AppAnimations.duration.medium,
    curve: AppAnimations.curve.emphasized,
  );

  /// Snackbar animation preset
  static final snackbar = AnimationConfig(
    duration: AppAnimations.duration.snackbar,
    curve: AppAnimations.curve.decelerate,
  );

  /// Tooltip animation preset
  static final tooltip = AnimationConfig(
    duration: AppAnimations.duration.fast,
    curve: AppAnimations.curve.standard,
  );

  /// Dropdown animation preset
  static final dropdown = AnimationConfig(
    duration: AppAnimations.duration.normal,
    curve: AppAnimations.curve.decelerate,
  );

  /// Expansion panel animation preset
  static final expansion = AnimationConfig(
    duration: AppAnimations.duration.medium,
    curve: AppAnimations.curve.emphasized,
  );

  /// Tab switching animation preset
  static final tab = AnimationConfig(
    duration: AppAnimations.duration.normal,
    curve: AppAnimations.curve.standard,
  );

  /// Navigation bar animation preset
  static final navigationBar = AnimationConfig(
    duration: AppAnimations.duration.navigationBar,
    curve: AppAnimations.curve.standard,
  );

  /// Fade in animation preset
  static final fadeIn = AnimationConfig(
    duration: AppAnimations.duration.normal,
    curve: AppAnimations.curve.decelerate,
  );

  /// Fade out animation preset
  static final fadeOut = AnimationConfig(
    duration: AppAnimations.duration.fast,
    curve: AppAnimations.curve.accelerate,
  );

  /// Scale up animation preset
  static final scaleUp = AnimationConfig(
    duration: AppAnimations.duration.medium,
    curve: AppAnimations.curve.emphasized,
  );

  /// Scale down animation preset
  static final scaleDown = AnimationConfig(
    duration: AppAnimations.duration.fast,
    curve: AppAnimations.curve.accelerate,
  );

  /// Slide in animation preset
  static final slideIn = AnimationConfig(
    duration: AppAnimations.duration.medium,
    curve: AppAnimations.curve.emphasized,
  );

  /// Slide out animation preset
  static final slideOut = AnimationConfig(
    duration: AppAnimations.duration.normal,
    curve: AppAnimations.curve.accelerate,
  );
}

/// Configuration class for animations
///
/// Combines duration and curve for easy reuse.
class AnimationConfig {
  /// Creates an animation configuration.
  const AnimationConfig({required this.duration, required this.curve});

  /// Animation duration
  final Duration duration;

  /// Animation curve
  final Curve curve;

  /// Creates a copy with modified properties
  AnimationConfig copyWith({Duration? duration, Curve? curve}) {
    return AnimationConfig(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }
}

/// Extension methods for AnimationController
extension AnimationControllerExtension on AnimationController {
  /// Forward with preset duration
  TickerFuture forwardWithDuration(Duration duration) {
    this.duration = duration;
    return forward();
  }

  /// Reverse with preset duration
  TickerFuture reverseWithDuration(Duration duration) {
    this.duration = duration;
    return reverse();
  }

  /// Repeat with preset duration
  TickerFuture repeatWithDuration(Duration duration, {bool reverse = false}) {
    this.duration = duration;
    return repeat(reverse: reverse);
  }
}

/// Helper widget for animated transitions
///
/// Simplifies creating animated widgets with consistent timing.
///
/// Example:
/// ```dart
/// AnimatedTransition(
///   config: AppAnimationPresets.fadeIn,
///   child: MyWidget(),
/// )
/// ```
class AnimatedTransition extends StatelessWidget {
  /// Creates an animated transition widget.
  const AnimatedTransition({
    super.key,
    required this.config,
    required this.child,
    this.onEnd,
  });

  /// Animation configuration
  final AnimationConfig config;

  /// Child widget to animate
  final Widget child;

  /// Callback when animation completes
  final VoidCallback? onEnd;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: config.duration,
      switchInCurve: config.curve,
      switchOutCurve: config.curve,
      child: child,
    );
  }
}
