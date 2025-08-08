// create_capsule_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:capp_box/core/service/auth_service.dart';
import 'package:capp_box/feature/login/services/login&register_datasources.dart';
import 'package:capp_box/feature/login/services/login&register_usecases.dart';
import 'package:capp_box/feature/login/services/model/user_model.dart';
import 'package:capp_box/product/database/hive/core/hive_database_manager.dart';
import 'package:capp_box/product/utility/enums/status_enum.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRegisterRemoteDatasource loginRegisterRemoteDatasource;
  final IAuthService authService;
  late final LoginRegisterUsecase loginRegisterUsecase;

  LoginBloc({IAuthService? authService})
    : loginRegisterRemoteDatasource = LoginRegisterRemoteDatasource(),
      authService = authService ?? AuthService(),
      super(const LoginState()) {
    loginRegisterUsecase = LoginRegisterUsecase(loginRegisterRemoteDatasource);
    on<LoginAction>(_onLoginAction);
    on<LogoutAction>(_onLogoutAction);
    on<LoginChangePhone>(_onLoginChangePhone);
    on<RegisterAction>(_onRegisterAction);
    on<AppleSignInAction>(_onAppleSignInAction);
    on<GoogleSignInAction>(_onGoogleSignInAction);
    on<EmailPasswordLoginAction>(_onEmailPasswordLoginAction);
    on<CheckAuthStatusAction>(_onCheckAuthStatusAction);
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

  void _onLogoutAction(LogoutAction event, Emitter<LoginState> emit) async {
    try {
      await authService.signOut();
      emit(
        state.copyWith(
          isAuthenticated: false,
          userEmail: '',
          userId: null,
          userDisplayName: null,
          status: StatusEnum.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          authError: 'Çıkış yapılırken hata oluştu: $e',
          status: StatusEnum.error,
        ),
      );
    }
  }

  void _onLoginChangePhone(LoginChangePhone event, Emitter<LoginState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onRegisterAction(
    RegisterAction event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final response = await loginRegisterUsecase.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      if (response.success == true && response.token.isNotEmpty) {
        await hiveDatabaseManager.saveUserModel(
          UserModel(name: event.name, token: 'Bearer ${response.token}'),
        );
        await hiveDatabaseManager.setFirst();
        emit(state.copyWith(isAuthenticated: true, status: StatusEnum.success));
      } else {
        emit(state.copyWith(isAuthenticated: false, status: StatusEnum.error));
        BotToast.showText(text: 'Kayıt başarısız');
      }
    } catch (e) {
      emit(state.copyWith(isAuthenticated: false, status: StatusEnum.error));
      BotToast.showText(text: 'Kayıt başarısız');
    }
  }

  // Apple Sign-In işlemi
  Future<void> _onAppleSignInAction(
    AppleSignInAction event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: StatusEnum.loading));

      final userCredential = await authService.signInWithApple();

      if (userCredential != null) {
        final user = userCredential.user;
        if (user != null) {
          await hiveDatabaseManager.saveUserModel(
            UserModel(
              name: user.displayName ?? 'Apple User',
              url: user.email ?? '',
              userId: user.uid,
              token: await user.getIdToken(),
            ),
          );

          emit(
            state.copyWith(
              isAuthenticated: true,
              userEmail: user.email ?? '',
              userId: user.uid,
              userDisplayName: user.displayName,
              status: StatusEnum.success,
              authError: null,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            isAuthenticated: false,
            status: StatusEnum.error,
            authError: 'Apple ile giriş başarısız',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isAuthenticated: false,
          status: StatusEnum.error,
          authError: 'Apple ile giriş hatası: $e',
        ),
      );
    }
  }

  // Google Sign-In işlemi
  Future<void> _onGoogleSignInAction(
    GoogleSignInAction event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: StatusEnum.loading));

      final userCredential = await authService.signInWithGoogle();

      if (userCredential != null) {
        final user = userCredential.user;
        if (user != null) {
          await hiveDatabaseManager.saveUserModel(
            UserModel(
              name: user.displayName ?? 'Google User',
              url: user.email ?? '',
              userId: user.uid,
              token: await user.getIdToken(),
            ),
          );

          emit(
            state.copyWith(
              isAuthenticated: true,
              userEmail: user.email ?? '',
              userId: user.uid,
              userDisplayName: user.displayName,
              status: StatusEnum.success,
              authError: null,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            isAuthenticated: false,
            status: StatusEnum.error,
            authError: 'Google ile giriş başarısız',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isAuthenticated: false,
          status: StatusEnum.error,
          authError: 'Google ile giriş hatası: $e',
        ),
      );
    }
  }

  // Email/Password ile giriş işlemi
  Future<void> _onEmailPasswordLoginAction(
    EmailPasswordLoginAction event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: StatusEnum.loading));

      final userCredential = await authService.signInWithEmailPassword(
        event.email,
        event.password,
      );

      if (userCredential != null) {
        final user = userCredential.user;
        if (user != null) {
          await hiveDatabaseManager.saveUserModel(
            UserModel(
              name: user.displayName ?? user.email ?? 'User',
              url: user.email ?? '',
              userId: user.uid,
              token: await user.getIdToken(),
            ),
          );

          emit(
            state.copyWith(
              isAuthenticated: true,
              userEmail: user.email ?? '',
              userId: user.uid,
              userDisplayName: user.displayName,
              status: StatusEnum.success,
              authError: null,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            isAuthenticated: false,
            status: StatusEnum.error,
            authError: 'Email veya şifre hatalı',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isAuthenticated: false,
          status: StatusEnum.error,
          authError: 'Giriş hatası: $e',
        ),
      );
    }
  }

  // Kullanıcı durumunu kontrol et
  Future<void> _onCheckAuthStatusAction(
    CheckAuthStatusAction event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final isLoggedIn = authService.isUserLoggedIn();

      if (isLoggedIn) {
        final user = authService.getCurrentUser();
        if (user != null) {
          emit(
            state.copyWith(
              isAuthenticated: true,
              userEmail: user.email ?? '',
              userId: user.uid,
              userDisplayName: user.displayName,
              status: StatusEnum.success,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(isAuthenticated: false, status: StatusEnum.success),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isAuthenticated: false,
          status: StatusEnum.error,
          authError: 'Durum kontrolü hatası: $e',
        ),
      );
    }
  }
}
