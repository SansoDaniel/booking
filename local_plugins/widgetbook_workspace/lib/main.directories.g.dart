// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:widgetbook_workspace/creation_example/creation_example.dart'
    as _i2;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookCategory(
    name: 'widgets',
    children: [
      _i1.WidgetbookFolder(
        name: 'Examples',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'Container',
            useCase: _i1.WidgetbookUseCase(
              name: 'Example',
              builder: _i2.buildExampleUseCase,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'GridView',
            useCase: _i1.WidgetbookUseCase(
              name: 'Example',
              builder: _i2.buildColorPalette,
            ),
          ),
        ],
      ),
    ],
  ),
];
