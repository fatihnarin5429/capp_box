part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileChangeName extends ProfileEvent {
  final String displayName;
  const ProfileChangeName({required this.displayName});

  @override
  List<Object> get props => [displayName];
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
  final String email;
  final String password;
  const ProfileLogout({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ProfileDelete extends ProfileEvent {
  final String email;
  final String password;
  const ProfileDelete({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
