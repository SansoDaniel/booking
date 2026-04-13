import 'package:project_architecture/core/base_classes/abstract/abstract_class.dart' show AppInterceptor;
import 'package:project_architecture/riverpod/login/providers/login_provider.dart';
import 'package:riverpod/riverpod.dart';

class LoginInterceptor extends AppInterceptor {
  final AutoDisposeStateNotifierProvider notifier = loginProvider;
}
