import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_architecture/riverpod/{{name.lowerCase()}}/providers/{{name.lowerCase()}}_notifier.dart';
import 'package:project_architecture/riverpod/{{name.lowerCase()}}/providers/{{name.lowerCase()}}_state.dart';

final {{name.camelCase()}}Provider = AutoDisposeStateNotifierProvider<{{name.pascalCase()}}Notifier, {{name.pascalCase()}}State>((ref) => {{name.pascalCase()}}Notifier());