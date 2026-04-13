import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booking_app/riverpod/login/providers/login_notifier.dart';
import 'package:booking_app/riverpod/login/providers/login_state.dart';

final loginProvider = AutoDisposeStateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier());