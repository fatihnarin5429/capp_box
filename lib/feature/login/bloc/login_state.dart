part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isAuthenticated;
  final String phone;
  const LoginState({this.isAuthenticated = false, this.phone = ''});

  LoginState copyWith({bool? isAuthenticated, String? phone}) {
    return LoginState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, phone];
}
