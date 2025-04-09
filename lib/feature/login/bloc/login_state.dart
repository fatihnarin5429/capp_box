part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isAuthenticated;
  final User? user;
  final String phone;
  const LoginState({
    this.isAuthenticated = false,
    this.user,
    this.phone = '',
  });

  LoginState copyWith({
    bool? isAuthenticated,
    User? user,
    String? phone,
  }) {
    return LoginState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, user, phone];
}
