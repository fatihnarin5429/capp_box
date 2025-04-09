// create_capsule_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:capp_box/feature/login/model/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginAction>(_onLoginAction);
    on<LogoutAction>(_onLogoutAction);
    on<LoginChangePhone>(_onLoginChangePhone);
  }

  Future<void> _onLoginAction(
    LoginAction event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(user: event.user));
    } catch (e) {
      emit(state.copyWith(
        isAuthenticated: false,
        user: null,
      ));
    }
  }

  void _onLogoutAction(
    LogoutAction event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      isAuthenticated: false,
      user: null,
    ));
  }

  void _onLoginChangePhone(
    LoginChangePhone event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(phone: event.phone));
  }
}
