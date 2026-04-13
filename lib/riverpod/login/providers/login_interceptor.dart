import 'package:booking_app/core/base_classes/abstract/abstract_class.dart' show AppInterceptor;
import 'package:booking_app/riverpod/login/providers/login_provider.dart';
import 'package:riverpod/riverpod.dart';

class LoginInterceptor extends AppInterceptor {
  final AutoDisposeStateNotifierProvider notifier = loginProvider;
}
