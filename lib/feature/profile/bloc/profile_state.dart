part of 'profile_bloc.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.photo = '',
    this.userId = '',
    this.token = '',
    this.isFirst = false,
    this.error,
    this.isLoggedIn = false,
    this.isDeleted = false,
  });

  final String name;
  final String email;
  final String phone;
  final String photo;
  final String userId;
  final String token;
  final bool isFirst;
  final String? error;
  final bool isLoggedIn;
  final bool isDeleted;

  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    photo,
    userId,
    token,
    isFirst,
    error,
    isLoggedIn,
    isDeleted,
  ];

  ProfileState copyWith({
    String? name,
    String? email,
    String? phone,
    String? photo,
    String? userId,
    String? token,
    bool? isFirst,
    String? error,
    bool? isLoggedIn,
    bool? isDeleted,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      isFirst: isFirst ?? this.isFirst,
      error: error ?? this.error,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
