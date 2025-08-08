part of 'login_bloc.dart';

class LoginState extends Equatable {
  final StatusEnum status;
  final bool isAuthenticated;
  final String phone;
  final String userEmail;
  final String? userId;
  final String? userDisplayName;
  final String? authError;

  const LoginState({
    this.status = StatusEnum.loading,
    this.isAuthenticated = false,
    this.phone = '',
    this.userEmail = '',
    this.userId,
    this.userDisplayName,
    this.authError,
  });

  LoginState copyWith({
    StatusEnum? status,
    bool? isAuthenticated,
    String? phone,
    String? userEmail,
    String? userId,
    String? userDisplayName,
    String? authError,
  }) {
    return LoginState(
      status: status ?? this.status,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      phone: phone ?? this.phone,
      userEmail: userEmail ?? this.userEmail,
      userId: userId ?? this.userId,
      userDisplayName: userDisplayName ?? this.userDisplayName,
      authError: authError ?? this.authError,
    );
  }

  @override
  List<Object?> get props => [
    status,
    isAuthenticated,
    phone,
    userEmail,
    userId,
    userDisplayName,
    authError,
  ];
}
