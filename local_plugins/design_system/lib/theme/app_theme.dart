import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart' show NoDefaultCupertinoThemeData;
import 'package:flutter/material.dart';

/// Theme cache manager for improved performance
///
/// Stores theme instances to avoid rebuilding them on every access.
/// Use this when you need to access themes frequently.
class AppThemeCache {
  AppThemeCache._();

  static final AppThemeCache _instance = AppThemeCache._();
  static AppThemeCache get instance => _instance;

  final Map<String, ThemeData> _cache = {};

  /// Get cached theme or build and cache it
  ThemeData getOrBuild(String key, ThemeData Function() builder) {
    if (!_cache.containsKey(key)) {
      _cache[key] = builder();
    }
    return _cache[key]!;
  }

  /// Clear specific theme from cache
  void clearTheme(String key) {
    _cache.remove(key);
  }

  /// Clear all cached themes
  void clearAll() {
    _cache.clear();
  }

  /// Check if theme is cached
  bool isCached(String key) {
    return _cache.containsKey(key);
  }

  /// Get cache size
  int get size => _cache.length;
}

class AppTheme {
  AppTheme._();

  /// Get default light theme
  static ThemeData get defaultLightTheme => buildTheme(AppColors.light);

  /// Get default dark theme
  static ThemeData get defaultDarkTheme => buildTheme(AppColors.dark);

  /// Create theme from custom colors
  static ThemeData customTheme(AppColors colors) => buildTheme(colors);

  static ThemeData buildTheme(
    AppColors colors, {
    Iterable<Adaptation<Object>>? adaptations,
    bool? applyElevationOverlayColor,
    NoDefaultCupertinoThemeData? cupertinoOverrideTheme,
    Iterable<ThemeExtension<dynamic>>? extensions,
    InputDecorationThemeData? inputDecorationTheme,
    MaterialTapTargetSize? materialTapTargetSize,
    PageTransitionsTheme? pageTransitionsTheme,
    TargetPlatform? platform,
    ScrollbarThemeData? scrollbarTheme,
    InteractiveInkFeatureFactory? splashFactory,
    VisualDensity? visualDensity,
    ColorScheme? colorScheme,
    Brightness? brightness,
    Color? colorSchemeSeed,
    Color? canvasColor,
    Color? cardColor,
    Color? disabledColor,
    Color? dividerColor,
    Color? focusColor,
    Color? highlightColor,
    Color? hintColor,
    Color? hoverColor,
    Color? scaffoldBackgroundColor,
    Color? shadowColor,
    Color? splashColor,
    Color? unselectedWidgetColor,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    IconThemeData? iconTheme,
    TextTheme? textTheme,
    Typography? typography,
    ActionIconThemeData? actionIconTheme,
    AppBarThemeData? appBarTheme,
    BadgeThemeData? badgeTheme,
    MaterialBannerThemeData? bannerTheme,
    BottomAppBarThemeData? bottomAppBarTheme,
    BottomNavigationBarThemeData? bottomNavigationBarTheme,
    BottomSheetThemeData? bottomSheetTheme,
    ButtonThemeData? buttonTheme,
    CardThemeData? cardTheme,
    CarouselViewThemeData? carouselViewTheme,
    CheckboxThemeData? checkboxTheme,
    ChipThemeData? chipTheme,
    DataTableThemeData? dataTableTheme,
    DatePickerThemeData? datePickerTheme,
    DialogThemeData? dialogTheme,
    DividerThemeData? dividerTheme,
    DrawerThemeData? drawerTheme,
    DropdownMenuThemeData? dropdownMenuTheme,
    ElevatedButtonThemeData? elevatedButtonTheme,
    ExpansionTileThemeData? expansionTileTheme,
    FilledButtonThemeData? filledButtonTheme,
    FloatingActionButtonThemeData? floatingActionButtonTheme,
    IconButtonThemeData? iconButtonTheme,
    ListTileThemeData? listTileTheme,
    MenuBarThemeData? menuBarTheme,
    MenuButtonThemeData? menuButtonTheme,
    MenuThemeData? menuTheme,
    NavigationBarThemeData? navigationBarTheme,
    NavigationDrawerThemeData? navigationDrawerTheme,
    NavigationRailThemeData? navigationRailTheme,
    OutlinedButtonThemeData? outlinedButtonTheme,
    PopupMenuThemeData? popupMenuTheme,
    ProgressIndicatorThemeData? progressIndicatorTheme,
    RadioThemeData? radioTheme,
    SearchBarThemeData? searchBarTheme,
    SearchViewThemeData? searchViewTheme,
    SegmentedButtonThemeData? segmentedButtonTheme,
    SliderThemeData? sliderTheme,
    SnackBarThemeData? snackBarTheme,
    SwitchThemeData? switchTheme,
    TabBarThemeData? tabBarTheme,
    TextButtonThemeData? textButtonTheme,
    TextSelectionThemeData? textSelectionTheme,
    TimePickerThemeData? timePickerTheme,
    ToggleButtonsThemeData? toggleButtonsTheme,
    TooltipThemeData? tooltipTheme,
  }) {
    final colorScheme = ColorScheme(
      brightness:
          colors.background.computeLuminance() > 0.5
              ? Brightness.light
              : Brightness.dark,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      primaryContainer: colors.primaryContainer,
      onPrimaryContainer: colors.onPrimaryContainer,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      secondaryContainer: colors.secondaryContainer,
      onSecondaryContainer: colors.onSecondaryContainer,
      tertiary: colors.tertiary,
      onTertiary: colors.onTertiary,
      tertiaryContainer: colors.tertiaryContainer,
      onTertiaryContainer: colors.onTertiaryContainer,
      error: colors.error,
      onError: colors.white,
      surface: colors.surface,
      onSurface: colors.onSurface,
      surfaceContainerHighest: colors.surfaceVariant,
      onSurfaceVariant: colors.onSurfaceVariant,
      outline: colors.outline,
      outlineVariant: colors.outlineVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      unselectedWidgetColor: unselectedWidgetColor,
      actionIconTheme: actionIconTheme ?? ActionIconThemeData(),
      badgeTheme: badgeTheme ?? BadgeThemeData(),
      bannerTheme: bannerTheme ?? MaterialBannerThemeData(),
      bottomAppBarTheme: bottomAppBarTheme ?? BottomAppBarThemeData(),
      bottomNavigationBarTheme:
          bottomNavigationBarTheme ?? BottomNavigationBarThemeData(),
      bottomSheetTheme: bottomSheetTheme ?? BottomSheetThemeData(),
      buttonTheme: buttonTheme ?? ButtonThemeData(),
      carouselViewTheme: carouselViewTheme ?? CarouselViewThemeData(),
      checkboxTheme: checkboxTheme ?? CheckboxThemeData(),
      dataTableTheme: dataTableTheme ?? DataTableThemeData(),
      datePickerTheme: datePickerTheme ?? DatePickerThemeData(),
      dialogTheme: dialogTheme ?? DialogThemeData(),
      drawerTheme: drawerTheme ?? DrawerThemeData(),
      dropdownMenuTheme: dropdownMenuTheme ?? DropdownMenuThemeData(),
      expansionTileTheme: expansionTileTheme ?? ExpansionTileThemeData(),
      extensions: [colors, ...?extensions],
      filledButtonTheme: filledButtonTheme ?? FilledButtonThemeData(),
      iconButtonTheme: iconButtonTheme ?? IconButtonThemeData(),
      listTileTheme: listTileTheme ?? ListTileThemeData(),
      materialTapTargetSize:
          materialTapTargetSize ?? MaterialTapTargetSize.padded,
      menuBarTheme: menuBarTheme ?? MenuBarThemeData(),
      menuButtonTheme: menuButtonTheme ?? MenuButtonThemeData(),
      menuTheme: menuTheme ?? MenuThemeData(),
      navigationBarTheme: navigationBarTheme ?? NavigationBarThemeData(),
      navigationDrawerTheme:
          navigationDrawerTheme ?? NavigationDrawerThemeData(),
      adaptations: adaptations ?? [],
      applyElevationOverlayColor: applyElevationOverlayColor,
      brightness: brightness ?? Brightness.light,
      canvasColor: canvasColor ?? colorScheme.surface,
      cardColor: cardColor ?? colorScheme.surface,
      colorSchemeSeed: colorSchemeSeed,
      cupertinoOverrideTheme: cupertinoOverrideTheme,
      disabledColor: disabledColor ?? colors.textDisabled,
      dividerColor: disabledColor,
      focusColor: focusColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
      highlightColor: highlightColor,
      hintColor: hintColor,
      hoverColor: hoverColor,
      navigationRailTheme: navigationRailTheme ?? NavigationRailThemeData(),
      package: package,
      pageTransitionsTheme: pageTransitionsTheme ?? PageTransitionsTheme(),
      platform: platform,
      popupMenuTheme: popupMenuTheme ?? PopupMenuThemeData(),
      progressIndicatorTheme:
          progressIndicatorTheme ?? ProgressIndicatorThemeData(),
      radioTheme: radioTheme ?? RadioThemeData(),
      scrollbarTheme: scrollbarTheme ?? ScrollbarThemeData(),
      searchBarTheme: searchBarTheme ?? SearchBarThemeData(),
      searchViewTheme: searchViewTheme ?? SearchViewThemeData(),
      segmentedButtonTheme: segmentedButtonTheme ?? SegmentedButtonThemeData(),
      sliderTheme: sliderTheme ?? SliderThemeData(),
      snackBarTheme: snackBarTheme ?? SnackBarThemeData(),
      shadowColor: shadowColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      switchTheme: switchTheme ?? SwitchThemeData(),
      tabBarTheme: tabBarTheme ?? TabBarThemeData(),
      textSelectionTheme: textSelectionTheme ?? TextSelectionThemeData(),
      timePickerTheme: timePickerTheme ?? TimePickerThemeData(),
      toggleButtonsTheme: toggleButtonsTheme ?? ToggleButtonsThemeData(),
      tooltipTheme: tooltipTheme ?? TooltipThemeData(),
      typography: typography ?? Typography(),
      visualDensity: visualDensity ?? VisualDensity.standard,
      textTheme:
          textTheme ??
          TextTheme(
            displayLarge: TextStyle(color: colors.textPrimary),
            displayMedium: TextStyle(color: colors.textPrimary),
            displaySmall: TextStyle(color: colors.textPrimary),
            headlineLarge: TextStyle(color: colors.textPrimary),
            headlineMedium: TextStyle(color: colors.textPrimary),
            headlineSmall: TextStyle(color: colors.textPrimary),
            titleLarge: TextStyle(color: colors.textPrimary),
            titleMedium: TextStyle(color: colors.textPrimary),
            titleSmall: TextStyle(color: colors.textPrimary),
            bodyLarge: TextStyle(color: colors.textPrimary),
            bodyMedium: TextStyle(color: colors.textPrimary),
            bodySmall: TextStyle(color: colors.textSecondary),
            labelLarge: TextStyle(color: colors.textPrimary),
            labelMedium: TextStyle(color: colors.textSecondary),
            labelSmall: TextStyle(color: colors.textDisabled),
          ),
      appBarTheme:
          appBarTheme ??
          AppBarTheme(
            backgroundColor: colors.surface,
            foregroundColor: colors.onSurface,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: colors.onSurface),
          ),
      cardTheme:
          cardTheme ??
          CardThemeData(
            color: colors.surface,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
      elevatedButtonTheme:
          elevatedButtonTheme ??
          ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
      outlinedButtonTheme:
          outlinedButtonTheme ??
          OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.primary,
              side: BorderSide(color: colors.outline),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
      textButtonTheme:
          textButtonTheme ??
          TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
      inputDecorationTheme:
          inputDecorationTheme ??
          InputDecorationTheme(
            filled: true,
            fillColor: colors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colors.error),
            ),
            labelStyle: TextStyle(color: colors.textSecondary),
            hintStyle: TextStyle(color: colors.textDisabled),
          ),
      chipTheme:
          chipTheme ??
          ChipThemeData(
            backgroundColor: colors.surfaceVariant,
            selectedColor: colors.primaryContainer,
            labelStyle: TextStyle(color: colors.textPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
      floatingActionButtonTheme:
          floatingActionButtonTheme ??
          FloatingActionButtonThemeData(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
          ),
      iconTheme: iconTheme ?? IconThemeData(color: colors.onSurface),
      dividerTheme:
          dividerTheme ?? DividerThemeData(color: colors.outline, thickness: 1),
    );
  }
}

extension ThemeColorExtension on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
