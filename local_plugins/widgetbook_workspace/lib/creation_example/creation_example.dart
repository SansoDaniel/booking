import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Example',
  type: Container,
  path: '[widgets]/Examples',
)
Widget buildExampleUseCase(BuildContext context) {
  return KeyBoardAccessibility(
    child: Container(
      width: context.knobs.doubleOrNull.input(label: 'Width', initialValue: 50),
      height: context.knobs.doubleOrNull.input(
        label: 'Height',
        initialValue: 50,
      ),
      color: context.knobs.colorOrNull(
        label: 'Colors',
        initialValue: Colors.amber,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Example',
  type: SingleChildScrollView,
  path: '[widgets]/Examples',
)
Widget buildColorPalette(BuildContext context) {
  String getHex(Color color) =>
      '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';

  final Map<String, Color> colors = {
    getHex(context.appColors.white): context.appColors.white,
    getHex(context.appColors.black): context.appColors.black,
    getHex(context.appColors.brand): context.appColors.brand,
    getHex(context.appColors.grayLight): context.appColors.grayLight,
    getHex(context.appColors.grayDark): context.appColors.grayDark,
    getHex(context.appColors.success): context.appColors.success,
    getHex(context.appColors.error): context.appColors.error,
    getHex(context.appColors.warning): context.appColors.warning,
  };

  return Wrap(
    spacing: AppSpacing.m,
    runSpacing: AppSpacing.m,
    children:
        colors.entries.map((e) {
          return Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(AppSpacing.xxl),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(AppRadius.s),
                      color: e.value,
                      border: Border.all(),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    e.key,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: context.appColors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
  );
}
