import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_architecture/riverpod/{{name.lowerCase()}}/providers/{{name.lowerCase()}}_state.dart';

class {{name.pascalCase()}}Notifier extends StateNotifier<{{name.pascalCase()}}State> {
  {{name.pascalCase()}}Notifier() : super({{name.pascalCase()}}State());
}
