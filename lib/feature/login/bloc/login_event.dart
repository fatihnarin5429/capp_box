part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginAction extends LoginEvent {
  final String phone;

  const LoginAction({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class LogoutAction extends LoginEvent {}

class RegisterAction extends LoginEvent {
  final String name;
  final String email;
  final String password;

  const RegisterAction({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

class LoginChangePhone extends LoginEvent {
  final String phone;
  const LoginChangePhone({required this.phone});

  @override
  List<Object?> get props => [phone];
}

// Firebase Authentication Events
class AppleSignInAction extends LoginEvent {}

class GoogleSignInAction extends LoginEvent {}

class EmailPasswordLoginAction extends LoginEvent {
  final String email;
  final String password;

  const EmailPasswordLoginAction({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class CheckAuthStatusAction extends LoginEvent {}
