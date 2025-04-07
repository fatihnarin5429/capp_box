part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isAuthenticated;
  final User? user;

  const LoginState({
    this.isAuthenticated = false,
    this.user,
  });

  LoginState copyWith({
    bool? isAuthenticated,
    User? user,
  }) {
    return LoginState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, user];
}
