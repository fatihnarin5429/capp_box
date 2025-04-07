part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginAction extends LoginEvent {
  final User user;

  const LoginAction({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class LogoutAction extends LoginEvent {}

class RegisterAction extends LoginEvent {
  final User user;

  const RegisterAction({
    required this.user,
  });
}
