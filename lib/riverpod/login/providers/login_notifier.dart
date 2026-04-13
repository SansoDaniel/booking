import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booking_app/riverpod/login/providers/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());
}
