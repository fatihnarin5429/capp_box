part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileChangeName extends ProfileEvent {
  final String name;
  const ProfileChangeName({required this.name});

  @override
  List<Object> get props => [name];
}

class ProfileChangeEmail extends ProfileEvent {
  final String email;
  const ProfileChangeEmail({required this.email});

  @override
  List<Object> get props => [email];
}

class ProfileChangePhone extends ProfileEvent {
  final String phone;
  const ProfileChangePhone({required this.phone});

  @override
  List<Object> get props => [phone];
}

class ProfileChangePassword extends ProfileEvent {
  final String password;
  const ProfileChangePassword({required this.password});

  @override
  List<Object> get props => [password];
}

class ProfileChangeImage extends ProfileEvent {
  final String imagePath;
  const ProfileChangeImage({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

class ProfileLogout extends ProfileEvent {
  const ProfileLogout();
}

class ProfileDelete extends ProfileEvent {
  const ProfileDelete();
}
