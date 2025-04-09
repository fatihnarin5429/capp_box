part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginAction extends LoginEvent {
  final User user;
  final String phone;

  const LoginAction({
    required this.user,
    required this.phone,
  });

  @override
  List<Object?> get props => [user, phone];
}

class LogoutAction extends LoginEvent {}

class RegisterAction extends LoginEvent {
  final User user;
  final String phone;

  const RegisterAction({
    required this.user,
    required this.phone,
  });

  @override
  List<Object?> get props => [user, phone];
}

class LoginChangePhone extends LoginEvent {
  final String phone;
  const LoginChangePhone({required this.phone});

  @override
  List<Object?> get props => [phone];
}
