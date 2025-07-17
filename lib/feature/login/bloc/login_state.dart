part of 'login_bloc.dart';

class LoginState extends Equatable {
  final StatusEnum status;
  final bool isAuthenticated;
  final String phone;
  const LoginState({
    this.status = StatusEnum.loading,
    this.isAuthenticated = false,
    this.phone = '',
  });

  LoginState copyWith({
    StatusEnum? status,
    bool? isAuthenticated,
    String? phone,
  }) {
    return LoginState(
      status: status ?? this.status,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [status, isAuthenticated, phone];
}
