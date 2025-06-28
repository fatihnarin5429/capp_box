// create_capsule_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:capp_box/feature/login/services/login&register_datasources.dart';
import 'package:capp_box/feature/login/services/login&register_usecases.dart';
import 'package:capp_box/feature/login/services/model/user_model.dart';
import 'package:capp_box/product/database/hive/core/hive_database_manager.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRegisterRemoteDatasource loginRegisterRemoteDatasource;
  late final LoginRegisterUsecase loginRegisterUsecase;

  LoginBloc()
    : loginRegisterRemoteDatasource = LoginRegisterRemoteDatasource(),
      super(const LoginState()) {
    loginRegisterUsecase = LoginRegisterUsecase(loginRegisterRemoteDatasource);
    on<LoginAction>(_onLoginAction);
    on<LogoutAction>(_onLogoutAction);
    on<LoginChangePhone>(_onLoginChangePhone);
    on<RegisterAction>(_onRegisterAction);
  }

  HiveDatabaseManager hiveDatabaseManager = HiveDatabaseManager();

  Future<void> _onLoginAction(
    LoginAction event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(phone: event.phone));
    } catch (e) {
      emit(state.copyWith(isAuthenticated: false));
    }
  }

  void _onLogoutAction(LogoutAction event, Emitter<LoginState> emit) {
    emit(state.copyWith(isAuthenticated: false));
  }

  void _onLoginChangePhone(LoginChangePhone event, Emitter<LoginState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onRegisterAction(RegisterAction event, Emitter<LoginState> emit) async {
    try {
      final response = await loginRegisterUsecase.register(
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
      );
      if (response.success) {
        hiveDatabaseManager.saveUserModel(
          UserModel(name: event.name, token: response.token),
        );
      }
      hiveDatabaseManager.setFirst();
      emit(state.copyWith(isAuthenticated: true));
    } catch (e) {
      emit(state.copyWith(isAuthenticated: false));
    }
  }
}
