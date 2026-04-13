import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/app_localizations.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appBuilder: (context, child) {
        return MaterialApp(debugShowCheckedModeBanner: false, home: child);
      },
      directories: directories,
      addons: [
        BuilderAddon(
          name: 'Accessibility',
          builder: (context, child) => AccessibilityTools(child: child),
        ),
        DeviceFrameAddon(devices: [...Devices.ios.all, ...Devices.android.all]),
        InspectorAddon(),
        LocalizationAddon(
          locales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
        AlignmentAddon(),
      ],
    );
  }
}
