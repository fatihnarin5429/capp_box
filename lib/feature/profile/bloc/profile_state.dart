part of 'profile_bloc.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.displayName = '',
    this.email = '',
    this.currentPassword = '',
    this.newPassword = '',
    this.phone = '',
    this.error = null,
    this.name = '',
    this.password = '',
    this.imagePath,
    this.isLoggedIn = false,
    this.isDeleted = false,
  });

  final String displayName;
  final String email;
  final String phone;
  final String currentPassword;
  final String newPassword;
  final String? error;
  final String? name;
  final String password;
  final String? imagePath;
  final bool isLoggedIn;
  final bool isDeleted;
  @override
  List<Object?> get props => [
        displayName,
        email,
        phone,
        error,
        name,
        password,
        imagePath,
        isLoggedIn,
        isDeleted,
      ];

  ProfileState copyWith({
    String? displayName,
    String? email,
    String? phone,
    String? name,
    String? error,
    String? password,
    bool? isLoggedIn,
    bool? isDeleted,
    String? imagePath,
  }) {
    return ProfileState(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      error: error ?? this.error,
      password: password ?? this.password,
      imagePath: imagePath ?? this.imagePath,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
