import 'package:project_architecture/core/base_classes/abstract/abstract_class.dart' show AppInterceptor;
import 'package:project_architecture/riverpod/{{name.lowerCase()}}/providers/{{name.lowerCase()}}_provider.dart';
import 'package:riverpod/riverpod.dart';

class {{name.pascalCase()}}Interceptor extends AppInterceptor {
  final AutoDisposeStateNotifierProvider notifier = {{name.camelCase()}}Provider;
}
