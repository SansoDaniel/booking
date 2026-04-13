# Design System

A comprehensive Flutter design system package providing design tokens, theme configuration, and reusable components for consistent UI development.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Design Tokens](#design-tokens)
  - [Colors](#colors)
  - [Typography](#typography)
  - [Spacing](#spacing)
  - [Radius](#radius)
  - [Shadows & Elevation](#shadows--elevation)
  - [Breakpoints](#breakpoints)
  - [Animations](#animations)
- [Theme System](#theme-system)
- [Theme Caching](#theme-caching)
- [Components](#components)
- [Testing](#testing)
- [Best Practices](#best-practices)

## Overview

This design system provides a complete set of design tokens and components following Material Design 3 guidelines. It ensures consistency across the application and simplifies theme management (light/dark mode).

**Key Features:**
- Semantic color system with Material Design 3 support
- Comprehensive typography scale with pre-defined text styles
- Consistent spacing and border radius tokens
- Shadow and elevation system
- Responsive breakpoints for adaptive layouts
- Animation duration and curve tokens
- Theme caching for improved performance
- Theme-aware components
- Full light/dark mode support
- Complete testing infrastructure

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  design_system:
    path: local_plugins/design_system
```

Import in your Dart files:

```dart
import 'package:design_system/design_system.dart';
```

## Design Tokens

Design tokens are the foundational building blocks of the design system. Always use these constants instead of hardcoded values.

### Colors

The color system uses `AppColors` as a theme extension with semantic naming following Material Design 3.

**Accessing Colors:**

```dart
// Get colors from theme
final colors = Theme.of(context).extension<AppColors>()!;

// Or using extension method (if available)
final colors = context.appColors;

// Usage
Container(
  color: colors.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: colors.onPrimary),
  ),
)
```

**Color Categories:**

| Category | Properties | Use Case |
|----------|-----------|----------|
| **Base** | `white`, `black`, `transparent` | Foundation colors |
| **Brand** | `brand`, `grayLight`, `grayDark` | Material color palettes with shades 50-900 |
| **Status** | `error`, `warning`, `success`, `info` | Feedback and alerts |
| **Primary** | `primary`, `onPrimary`, `primaryContainer`, `onPrimaryContainer` | Main brand actions |
| **Secondary** | `secondary`, `onSecondary`, `secondaryContainer`, `onSecondaryContainer` | Secondary actions |
| **Tertiary** | `tertiary`, `onTertiary`, `tertiaryContainer`, `onTertiaryContainer` | Accent elements |
| **Surface** | `surface`, `onSurface`, `surfaceVariant`, `onSurfaceVariant` | Cards, sheets, backgrounds |
| **Background** | `background`, `onBackground` | Page backgrounds |
| **Outline** | `outline`, `outlineVariant` | Borders and dividers |
| **Text** | `textPrimary`, `textSecondary`, `textDisabled` | Text hierarchy |

**Material Color Shades:**

```dart
final colors = Theme.of(context).extension<AppColors>()!;

// Access brand color shades
colors.brand[50]   // Lightest
colors.brand[100]
colors.brand[200]
colors.brand[300]
colors.brand[400]
colors.brand[500]  // Default
colors.brand[600]
colors.brand[700]
colors.brand[800]
colors.brand[900]  // Darkest
```

### Typography

Complete typography system with font sizes, weights, line heights, letter spacing, and pre-defined text styles.

**Design Tokens:**

```dart
// Font Sizes (logical pixels)
AppTypography.fontSize.xs     // 10.0
AppTypography.fontSize.s      // 12.0
AppTypography.fontSize.m      // 14.0 (body text)
AppTypography.fontSize.l      // 16.0 (default)
AppTypography.fontSize.xl     // 18.0
AppTypography.fontSize.xxl    // 20.0
AppTypography.fontSize.h6     // 24.0
AppTypography.fontSize.h5     // 28.0
AppTypography.fontSize.h4     // 32.0
AppTypography.fontSize.h3     // 36.0
AppTypography.fontSize.h2     // 40.0
AppTypography.fontSize.h1     // 48.0
AppTypography.fontSize.display // 56.0

// Font Weights
AppTypography.fontWeight.thin        // 100
AppTypography.fontWeight.extraLight  // 200
AppTypography.fontWeight.light       // 300
AppTypography.fontWeight.regular     // 400 (default)
AppTypography.fontWeight.medium      // 500
AppTypography.fontWeight.semiBold    // 600
AppTypography.fontWeight.bold        // 700
AppTypography.fontWeight.extraBold   // 800
AppTypography.fontWeight.black       // 900

// Line Heights (multipliers)
AppTypography.lineHeight.tight    // 1.2 (headings)
AppTypography.lineHeight.normal   // 1.5 (default)
AppTypography.lineHeight.relaxed  // 1.75
AppTypography.lineHeight.loose    // 2.0

// Letter Spacing
AppTypography.letterSpacing.tight      // -0.5
AppTypography.letterSpacing.normal     // 0.0 (default)
AppTypography.letterSpacing.wide       // 0.5
AppTypography.letterSpacing.extraWide  // 1.0
AppTypography.letterSpacing.wider      // 1.5
```

**Pre-defined Text Styles:**

```dart
// Display styles
Text('Title', style: AppTextStyles.displayLarge)   // 56px, bold
Text('Title', style: AppTextStyles.displayMedium)  // 48px, bold
Text('Title', style: AppTextStyles.displaySmall)   // 40px, semibold

// Heading styles
Text('Title', style: AppTextStyles.h1)  // 48px, bold
Text('Title', style: AppTextStyles.h2)  // 40px, bold
Text('Title', style: AppTextStyles.h3)  // 36px, semibold
Text('Title', style: AppTextStyles.h4)  // 32px, semibold
Text('Title', style: AppTextStyles.h5)  // 28px, medium
Text('Title', style: AppTextStyles.h6)  // 24px, medium

// Body styles
Text('Body', style: AppTextStyles.bodyLarge)  // 16px
Text('Body', style: AppTextStyles.body)       // 14px (default)
Text('Body', style: AppTextStyles.bodySmall)  // 12px

// Label styles
Text('Label', style: AppTextStyles.labelLarge)  // 14px, medium, wide
Text('Label', style: AppTextStyles.label)       // 12px, medium, wide
Text('Label', style: AppTextStyles.labelSmall)  // 10px, medium, wider

// Button styles
Text('Button', style: AppTextStyles.buttonLarge)  // 16px, medium
Text('Button', style: AppTextStyles.button)       // 14px, medium
Text('Button', style: AppTextStyles.buttonSmall)  // 12px, medium

// Caption styles
Text('Caption', style: AppTextStyles.caption)   // 12px, regular
Text('Label', style: AppTextStyles.overline)    // 10px, medium, wider
```

**Custom Typography:**

```dart
Text(
  'Custom text',
  style: TextStyle(
    fontSize: AppTypography.fontSize.l,
    fontWeight: AppTypography.fontWeight.bold,
    height: AppTypography.lineHeight.normal,
    letterSpacing: AppTypography.letterSpacing.wide,
  ),
)
```

### Spacing

Consistent spacing values for padding, margins, and gaps.

```dart
AppSpacing.none  // 0.0
AppSpacing.xxs   // 2.0
AppSpacing.xs    // 4.0
AppSpacing.s     // 8.0
AppSpacing.sm    // 10.0
AppSpacing.m     // 12.0
AppSpacing.l     // 16.0
AppSpacing.xl    // 20.0
AppSpacing.xxl   // 24.0
```

**Usage Examples:**

```dart
// Padding
Padding(
  padding: EdgeInsets.all(AppSpacing.m),
  child: Text('Padded content'),
)

// Margin
Container(
  margin: EdgeInsets.symmetric(
    horizontal: AppSpacing.l,
    vertical: AppSpacing.m,
  ),
  child: Text('Content'),
)

// Gap in Column/Row
Column(
  children: [
    Text('Item 1'),
    SizedBox(height: AppSpacing.s),
    Text('Item 2'),
  ],
)
```

### Radius

Border radius values for rounded corners.

```dart
AppRadius.none  // 0 (sharp corners)
AppRadius.xxs   // 2.0
AppRadius.xs    // 4.0
AppRadius.s     // 8.0
AppRadius.m     // 12.0
AppRadius.l     // 16.0
AppRadius.xl    // 20.0
AppRadius.xxl   // 24.0
```

**Usage Examples:**

```dart
// All corners
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(AppRadius.m),
  ),
  child: Text('Rounded container'),
)

// Specific corners
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: AppRadius.l,
      topRight: AppRadius.l,
      bottomLeft: AppRadius.xs,
      bottomRight: AppRadius.xs,
    ),
  ),
)

// Circular radius
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.s.x),
  ),
)
```

### Shadows & Elevation

Material Design elevation system with pre-defined shadow layers.

**BoxShadow Lists:**

```dart
AppShadows.none  // No shadow (elevation 0)
AppShadows.xs    // Elevation 1 - Subtle shadow
AppShadows.s     // Elevation 2 - Buttons, chips, cards at rest
AppShadows.m     // Elevation 4 - Raised buttons, cards on hover
AppShadows.l     // Elevation 8 - Dropdowns, menus, search bars
AppShadows.xl    // Elevation 16 - Modal dialogs, pickers
AppShadows.xxl   // Elevation 24 - Bottom sheets, navigation drawers
```

**Elevation Values (for Material widgets):**

```dart
AppElevation.none  // 0.0
AppElevation.xs    // 1.0
AppElevation.s     // 2.0
AppElevation.m     // 4.0
AppElevation.l     // 8.0
AppElevation.xl    // 16.0
AppElevation.xxl   // 24.0
```

**Usage Examples:**

```dart
// With Container
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: AppShadows.m,
    borderRadius: BorderRadius.circular(AppRadius.m.x),
  ),
  child: Text('Card with shadow'),
)

// With Material widgets
Card(
  elevation: AppElevation.s,
  child: Text('Elevated card'),
)

// Animated shadow
AnimatedContainer(
  duration: Duration(milliseconds: 200),
  decoration: BoxDecoration(
    boxShadow: isHovered ? AppShadows.l : AppShadows.s,
  ),
)
```

**Inner Shadows:**

Flutter doesn't support inset shadows natively. Use `AppInnerShadow` with custom painters or border simulation:

```dart
// Using border to simulate inner shadow
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(
      color: AppInnerShadow.light.color,
      width: AppInnerShadow.light.width,
    ),
  ),
)

// Available inner shadow presets
AppInnerShadow.light   // 6% opacity, 1.0 width, 2.0 blur
AppInnerShadow.medium  // 10% opacity, 1.5 width, 3.0 blur
AppInnerShadow.dark    // 16% opacity, 2.0 width, 4.0 blur
```

### Breakpoints

Responsive breakpoints for creating adaptive layouts across different screen sizes.

**Breakpoint Values:**

```dart
AppBreakpoints.xs      // 0px - Extra small (mobile portrait)
AppBreakpoints.sm      // 576px - Small (mobile landscape)
AppBreakpoints.md      // 768px - Medium (tablets)
AppBreakpoints.lg      // 992px - Large (desktops)
AppBreakpoints.xl      // 1200px - Extra large (large desktops)
AppBreakpoints.xxl     // 1400px - Extra extra large

// Semantic aliases
AppBreakpoints.mobile        // 0px
AppBreakpoints.tablet        // 768px
AppBreakpoints.desktop       // 992px
AppBreakpoints.largeDesktop  // 1200px
```

**BuildContext Extensions:**

```dart
// Check screen size
if (context.isMobile) {
  return MobileLayout();
} else if (context.isTablet) {
  return TabletLayout();
} else {
  return DesktopLayout();
}

// Get current breakpoint name
print(context.breakpointName); // 'xs', 'sm', 'md', 'lg', 'xl', 'xxl'

// Get responsive values
final padding = context.responsive(
  xs: 8.0,
  sm: 12.0,
  md: 16.0,
  lg: 20.0,
  xl: 24.0,
);
```

**ResponsiveBuilder Widget:**

```dart
ResponsiveBuilder(
  mobile: (context) => MobileLayout(),
  tablet: (context) => TabletLayout(),
  desktop: (context) => DesktopLayout(),
)
```

**Advanced ResponsiveBuilder:**

```dart
ResponsiveBuilderAdvanced(
  xs: (context) => ExtraSmallLayout(),
  sm: (context) => SmallLayout(),
  md: (context) => MediumLayout(),
  lg: (context) => LargeLayout(),
  xl: (context) => ExtraLargeLayout(),
  xxl: (context) => ExtraExtraLargeLayout(),
)
```

**ResponsiveValue Helper:**

```dart
final fontSize = ResponsiveValue<double>(
  context: context,
  xs: 14.0,
  sm: 16.0,
  md: 18.0,
  lg: 20.0,
).value;
```

### Animations

Animation duration and curve tokens for consistent motion design.

**Animation Durations:**

```dart
// Duration tokens
AppAnimations.duration.instant      // 0ms - No animation
AppAnimations.duration.veryFast     // 75ms - Micro-interactions
AppAnimations.duration.fast         // 150ms - Quick transitions
AppAnimations.duration.normal       // 200ms - Default speed
AppAnimations.duration.medium       // 300ms - Comfortable speed
AppAnimations.duration.slow         // 400ms - Deliberate motion
AppAnimations.duration.verySlow     // 500ms - Emphasized motion
AppAnimations.duration.extraSlow    // 700ms - Extended motion

// Semantic aliases
AppAnimations.duration.button           // 150ms
AppAnimations.duration.dialog           // 300ms
AppAnimations.duration.pageTransition   // 400ms
AppAnimations.duration.drawer           // 300ms
AppAnimations.duration.snackbar         // 250ms
AppAnimations.duration.tooltip          // 150ms
AppAnimations.duration.dropdown         // 200ms
AppAnimations.duration.expansion        // 300ms
AppAnimations.duration.tab              // 200ms
AppAnimations.duration.navigationBar    // 250ms
```

**Animation Curves:**

```dart
// Standard curves
AppAnimations.curve.linear          // No easing
AppAnimations.curve.ease            // Gentle acceleration/deceleration
AppAnimations.curve.easeIn          // Gradual acceleration
AppAnimations.curve.easeOut         // Gradual deceleration
AppAnimations.curve.easeInOut       // Symmetric easing

// Material emphasized curves
AppAnimations.curve.standard        // Default (easeInOut)
AppAnimations.curve.emphasized      // Attention-grabbing
AppAnimations.curve.decelerate      // For entering elements
AppAnimations.curve.accelerate      // For exiting elements

// Advanced curves
AppAnimations.curve.fastOutSlowIn   // Material motion standard
AppAnimations.curve.bounce          // Bounce effect
AppAnimations.curve.elastic         // Elastic effect

// Semantic aliases
AppAnimations.curve.entrance        // For enter animations
AppAnimations.curve.exit            // For exit animations
AppAnimations.curve.dialog          // For dialogs/modals
AppAnimations.curve.smooth          // For smooth transitions
```

**Animation Presets:**

Pre-configured animation settings combining duration and curve:

```dart
// Use with AnimatedContainer
AnimatedContainer(
  duration: AppAnimationPresets.button.duration,
  curve: AppAnimationPresets.button.curve,
  child: MyButton(),
)

// Available presets
AppAnimationPresets.button
AppAnimationPresets.dialog
AppAnimationPresets.pageTransition
AppAnimationPresets.drawer
AppAnimationPresets.snackbar
AppAnimationPresets.tooltip
AppAnimationPresets.dropdown
AppAnimationPresets.expansion
AppAnimationPresets.tab
AppAnimationPresets.navigationBar
AppAnimationPresets.fadeIn
AppAnimationPresets.fadeOut
AppAnimationPresets.scaleUp
AppAnimationPresets.scaleDown
AppAnimationPresets.slideIn
AppAnimationPresets.slideOut
```

**AnimationConfig Class:**

```dart
// Create custom animation config
final customAnimation = AnimationConfig(
  duration: Duration(milliseconds: 250),
  curve: Curves.easeInOut,
);

// Modify existing config
final modifiedAnimation = AppAnimationPresets.button.copyWith(
  duration: Duration(milliseconds: 300),
);
```

**Usage Examples:**

```dart
// Simple animated container
AnimatedContainer(
  duration: AppAnimations.duration.normal,
  curve: AppAnimations.curve.smooth,
  width: isExpanded ? 200 : 100,
  child: MyWidget(),
)

// Button with hover animation
AnimatedContainer(
  duration: AppAnimations.duration.button,
  curve: AppAnimations.curve.smooth,
  transform: isHovered
    ? Matrix4.identity()..scale(1.05)
    : Matrix4.identity(),
  child: ElevatedButton(
    onPressed: () {},
    child: Text('Hover me'),
  ),
)

// Page transition
PageRouteBuilder(
  transitionDuration: AppAnimations.duration.pageTransition,
  pageBuilder: (context, animation, secondaryAnimation) => NextPage(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: AppAnimations.curve.emphasized,
      ),
      child: child,
    );
  },
)
```

**AnimationController Extensions:**

```dart
// Use with AnimationController
final controller = AnimationController(vsync: this);

controller.forwardWithDuration(AppAnimations.duration.medium);
controller.reverseWithDuration(AppAnimations.duration.fast);
controller.repeatWithDuration(AppAnimations.duration.slow, reverse: true);
```

## Theme System

The theme system uses `AppTheme` class to manage light and dark themes with customization support.

**Basic Setup:**

```dart
import 'package:design_system/design_system.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    return MaterialApp(
      title: 'My App',
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: ThemeMode.system, // or ThemeMode.light / ThemeMode.dark
      home: HomePage(),
    );
  }
}
```

**Custom Theme Configuration:**

```dart
final appTheme = AppTheme(
  customizedLightConfig: ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green,
    ),
    // Override any ThemeData properties
  ),
  customizedDarkConfig: ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white,
    ),
  ),
);

// Use in MaterialApp
MaterialApp(
  theme: appTheme.light,
  darkTheme: appTheme.dark,
  // ...
)
```

**Accessing Theme in Widgets:**

```dart
// Get theme
final theme = Theme.of(context);

// Get brightness
final isDarkMode = theme.brightness == Brightness.dark;

// Get custom colors
final colors = theme.extension<AppColors>()!;

// Use theme colors
Container(
  color: colors.primary,
  child: Text(
    'Themed content',
    style: theme.textTheme.bodyLarge,
  ),
)
```

## Theme Caching

The design system includes a theme caching mechanism to improve performance by avoiding redundant theme rebuilds.

**AppThemeCache:**

A singleton cache manager that stores ThemeData instances:

```dart
// Get cache instance
final cache = AppThemeCache.instance;

// Get or build theme with caching
final theme = cache.getOrBuild('my_light_theme', () {
  return appTheme.light;
});

// Check if theme is cached
if (cache.isCached('my_light_theme')) {
  print('Theme is already in cache');
}

// Clear specific theme
cache.clearTheme('my_light_theme');

// Clear all cached themes
cache.clearAll();

// Get cache size
print('Cached themes: ${cache.size}');
```

**Usage in MaterialApp:**

```dart
class MyApp extends StatelessWidget {
  final appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeCache.instance.getOrBuild('light', () => appTheme.light),
      darkTheme: AppThemeCache.instance.getOrBuild('dark', () => appTheme.dark),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
```

**Benefits:**

- **Performance**: Themes are built only once and reused
- **Memory Efficient**: Singleton pattern ensures single cache instance
- **Flexible**: Can cache multiple theme variations with different keys
- **Easy to Use**: Simple API with getOrBuild pattern

**Best Practices:**

1. Use caching for themes that don't change frequently
2. Clear cache when theme configuration changes dynamically
3. Use descriptive keys for different theme variations
4. Cache themes at app initialization for best performance

**Example with Multiple Themes:**

```dart
// Cache different theme variations
final lightTheme = cache.getOrBuild('light_blue', () => blueAppTheme.light);
final darkTheme = cache.getOrBuild('dark_blue', () => blueAppTheme.dark);
final lightGreenTheme = cache.getOrBuild('light_green', () => greenAppTheme.light);

// Switch themes without rebuilding
void switchTheme(String themeKey) {
  setState(() {
    currentTheme = cache.getOrBuild(themeKey, () => buildTheme(themeKey));
  });
}
```

**Memory Management:**

```dart
// Clear cache when theme configuration changes
void updateThemeColors(Color newPrimaryColor) {
  // Clear old cached themes
  AppThemeCache.instance.clearAll();

  // Update theme configuration
  // New themes will be cached on next build
}

// Clear specific theme when no longer needed
void removeUnusedTheme() {
  AppThemeCache.instance.clearTheme('unused_theme_key');
}
```

## Components

### KeyBoardAccessibility

Wraps widgets with focus indicators for better keyboard navigation accessibility.

**Features:**
- Animated focus transitions
- Theme-aware default colors (light/dark mode)
- Configurable styling
- Uses design tokens

**Basic Usage:**

```dart
KeyBoardAccessibility(
  child: TextButton(
    onPressed: () {},
    child: Text('Accessible Button'),
  ),
)
```

**Custom Styling:**

```dart
KeyBoardAccessibility(
  focusBorderColor: Colors.blue,
  focusBorderWidth: 3.0,
  focusPadding: 8.0,
  focusBorderRadius: AppRadius.m,
  animationDuration: Duration(milliseconds: 300),
  child: MyCustomWidget(),
)
```

**Properties:**

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `child` | Widget | required | Widget to wrap with focus indicators |
| `focusBorderColor` | Color? | Theme-aware | Border color when focused |
| `focusBorderWidth` | double | 2.0 | Width of focus border |
| `focusPadding` | double? | AppSpacing.xs (4.0) | Padding when focused |
| `focusBorderRadius` | Radius? | AppRadius.xs (4.0) | Border radius of focus indicator |
| `animationDuration` | Duration | 200ms | Duration of focus transition |

**Default Colors:**
- Light mode: `Colors.black54`
- Dark mode: `Colors.white70`

## Testing

The design system includes a complete testing infrastructure with helper utilities and custom matchers.

### Test Helpers

The test helpers are located in the `test/` directory and are intended for internal package testing only. They are not exported as part of the public API.

**DesignSystemTestHelpers:**

```dart
// In your test files within the design_system package
import '../test_helpers.dart';

// Wrap widget for testing
await tester.pumpWidget(
  DesignSystemTestHelpers.wrapWidget(MyWidget()),
);

// Create test colors
final colors = DesignSystemTestHelpers.createTestColors(
  primary: Colors.blue,
  error: Colors.red,
);

// Create test theme
final theme = DesignSystemTestHelpers.createTestTheme(
  brightness: Brightness.dark,
  colors: colors,
);

// Pump and settle helper
await DesignSystemTestHelpers.pumpAndSettleWidget(tester, MyWidget());

// Tap and settle
await DesignSystemTestHelpers.tapAndSettle(tester, find.byType(Button));

// Verify spacing consistency
DesignSystemTestHelpers.verifySpacingConsistency();

// Verify radius consistency
DesignSystemTestHelpers.verifyRadiusConsistency();
```

**WidgetTester Extensions:**

```dart
// Pump widget with theme
await tester.pumpWidgetWithTheme(MyWidget());

// Find and verify widget exists
final finder = tester.findAndVerify<MyButton>();

// Tap by type and settle
await tester.tapByTypeAndSettle<MyButton>();
```

**Custom Matchers:**

```dart
// Check if color is valid
expect(Colors.blue, DesignSystemMatchers.isValidColor());

// Check duration range
expect(
  Duration(milliseconds: 200),
  DesignSystemMatchers.isReasonableDuration(minMs: 100, maxMs: 500),
);

// Check if value is positive
expect(42, DesignSystemMatchers.isPositiveNumber());

// Check if spacing is from design tokens
expect(AppSpacing.m, DesignSystemMatchers.isDesignTokenSpacing());

// Check if radius is from design tokens
expect(AppRadius.m, DesignSystemMatchers.isDesignTokenRadius());
```

### Example Tests

**Testing Components:**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system/design_system.dart';
import '../test_helpers.dart';

void main() {
  group('KeyBoardAccessibility', () {
    testWidgets('should render child widget', (tester) async {
      await tester.pumpWidget(
        DesignSystemTestHelpers.wrapWidget(
          KeyBoardAccessibility(
            child: Text('Test Widget'),
          ),
        ),
      );

      expect(find.text('Test Widget'), findsOneWidget);
    });

    testWidgets('should use design tokens', (tester) async {
      await tester.pumpWidgetWithTheme(
        KeyBoardAccessibility(child: Text('Test')),
      );

      expect(find.byType(KeyBoardAccessibility), findsOneWidget);
    });
  });
}
```

**Testing Design Tokens:**

```dart
void main() {
  group('AppSpacing', () {
    test('should have correct values', () {
      expect(AppSpacing.m, 12.0);
      expect(AppSpacing.l, 16.0);
    });

    test('should be consistent', () {
      DesignSystemTestHelpers.verifySpacingConsistency();
    });

    test('spacing should be design token', () {
      expect(AppSpacing.m, DesignSystemMatchers.isDesignTokenSpacing());
    });
  });

  group('AppRadius', () {
    test('should have correct values', () {
      expect(AppRadius.m.x, 12.0);
      expect(AppRadius.l.x, 16.0);
    });

    test('should be consistent', () {
      DesignSystemTestHelpers.verifyRadiusConsistency();
    });
  });
}
```

**Testing Themes:**

```dart
void main() {
  group('AppColors', () {
    test('should create valid colors', () {
      final colors = DesignSystemTestHelpers.createTestColors();

      expect(colors.primary, DesignSystemMatchers.isValidColor());
      expect(colors.error, DesignSystemMatchers.isValidColor());
    });

    test('copyWith should update properties', () {
      final colors = DesignSystemTestHelpers.createTestColors();
      final updated = colors.copyWith(primary: Colors.green) as AppColors;

      expect(updated.primary, Colors.green);
    });

    test('lerp should interpolate correctly', () {
      final colors1 = DesignSystemTestHelpers.createTestColors(
        primary: Colors.blue,
      );
      final colors2 = colors1.copyWith(primary: Colors.red) as AppColors;
      final interpolated = colors1.lerp(colors2, 0.5) as AppColors;

      expect(interpolated.primary, isNot(Colors.blue));
      expect(interpolated.primary, isNot(Colors.red));
    });
  });
}
```

**Testing Responsive Layouts:**

```dart
testWidgets('should render mobile layout on small screen', (tester) async {
  tester.binding.window.physicalSizeTestValue = Size(375, 667);
  tester.binding.window.devicePixelRatioTestValue = 1.0;

  await tester.pumpWidget(
    DesignSystemTestHelpers.wrapWidget(
      Builder(
        builder: (context) {
          if (context.isMobile) {
            return Text('Mobile Layout');
          }
          return Text('Desktop Layout');
        },
      ),
    ),
  );

  expect(find.text('Mobile Layout'), findsOneWidget);

  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
});
```

**Testing Animations:**

```dart
testWidgets('should animate with correct duration', (tester) async {
  await tester.pumpWidget(
    DesignSystemTestHelpers.wrapWidget(
      AnimatedContainer(
        duration: AppAnimations.duration.normal,
        curve: AppAnimations.curve.smooth,
        width: 100,
        height: 100,
      ),
    ),
  );

  expect(
    AppAnimations.duration.normal,
    DesignSystemMatchers.isReasonableDuration(minMs: 100, maxMs: 300),
  );
});
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/theme/colors_test.dart

# Run with coverage
flutter test --coverage

# Run in watch mode
flutter test --watch
```

For more information about mockito, refer to: https://pub.dev/packages/mockito

## Best Practices

### DO:

✅ **Always use design tokens** instead of hardcoded values:
```dart
// Good
padding: EdgeInsets.all(AppSpacing.m)

// Bad
padding: EdgeInsets.all(12.0)
```

✅ **Use semantic color names** from theme extension:
```dart
// Good
color: colors.primary

// Bad
color: Color(0xFF1976D2)
```

✅ **Use pre-defined text styles** when possible:
```dart
// Good
Text('Title', style: AppTextStyles.h1)

// Bad
Text('Title', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold))
```

✅ **Make widgets theme-aware** by reading from context:
```dart
// Good
final theme = Theme.of(context);
final colors = theme.extension<AppColors>()!;

// Bad
final colors = lightColors; // Hardcoded
```

✅ **Use elevation system** for depth hierarchy:
```dart
// Good
boxShadow: AppShadows.m

// Bad
boxShadow: [BoxShadow(blurRadius: 4, offset: Offset(0, 2))]
```

### DON'T:

❌ **Don't hardcode design values:**
```dart
// Bad
Container(
  padding: EdgeInsets.all(12),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
  ),
)
```

❌ **Don't use `Colors.*` directly for theme-specific colors:**
```dart
// Bad
Container(color: Colors.blue)

// Good
Container(color: colors.primary)
```

❌ **Don't skip accessibility features:**
```dart
// Bad - no focus indicator
TextButton(onPressed: () {}, child: Text('Button'))

// Good - with accessibility
KeyBoardAccessibility(
  child: TextButton(onPressed: () {}, child: Text('Button')),
)
```

❌ **Don't create custom TextStyles without using tokens:**
```dart
// Bad
TextStyle(fontSize: 16, fontWeight: FontWeight.w600)

// Good
TextStyle(
  fontSize: AppTypography.fontSize.l,
  fontWeight: AppTypography.fontWeight.semiBold,
)
```

### Component Development Guidelines:

1. **Theme Awareness**: Always check `Theme.of(context).brightness` for dark/light mode
2. **Design Tokens**: Use spacing, radius, typography, and color tokens consistently
3. **Accessibility**: Include focus indicators and semantic labels
4. **Documentation**: Add comprehensive dartdoc comments with examples
5. **Testing**: Create model classes for components that need testing
6. **Animations**: Use consistent animation durations (150-300ms for most transitions)

### Performance Tips:

1. Use `const` constructors whenever possible
2. Design tokens are compile-time constants - use them for better performance
3. Cache theme extensions if accessed frequently in a widget
4. Use `AnimatedContainer` instead of custom animations for simple transitions

---

**Package Structure:**
```
design_system/
├── lib/
│   ├── components/
│   │   └── base_widget/
│   │       └── keyboard_accessibility.dart
│   ├── theme/
│   │   ├── animations.dart
│   │   ├── app_theme.dart
│   │   ├── breakpoints.dart
│   │   ├── colors.dart
│   │   ├── radius.dart
│   │   ├── shadows.dart
│   │   ├── spacing.dart
│   │   ├── typography.dart
│   │   ├── light/
│   │   │   └── light_theme.dart
│   │   └── dark/
│   │       └── dark_theme.dart
│   └── design_system.dart (main export)
├── test/
│   ├── components/
│   │   └── keyboard_accessibility_test.dart
│   ├── theme/
│   │   ├── colors_test.dart
│   │   └── spacing_test.dart
│   └── test_helpers.dart (internal test utilities)
└── README.md
```

For questions or contributions, please refer to the main project documentation.