import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/profile/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository = ProfileRepository();

  ProfileBloc() : super(const ProfileState()) {
    on<ProfileChangeName>(_onProfileChangeName);
    on<ProfileChangeEmail>(_onProfileChangeEmail);
    on<ProfileChangePassword>(_onProfileChangePassword);
    on<ProfileChangePhone>(_onProfileChangePhone);
    on<ProfileChangeImage>(_onProfileChangeImage);
    on<ProfileLogout>(_onProfileLogout);
    on<ProfileDelete>(_onProfileDelete);
  }

  Future<void> _onProfileChangeName(
    ProfileChangeName event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(name: event.name));
    final user = await _profileRepository.getUser();
    if (user != null) {
      final updatedUser = user.copyWith(name: event.name);
      await _profileRepository.updateUser(updatedUser);
    }
  }

  Future<void> _onProfileChangeEmail(
    ProfileChangeEmail event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
    final user = await _profileRepository.getUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        url: event.email,
      ); // UserModel'de email alanı yoksa url kullanılıyor, gerekirse UserModel'e email ekle.
      await _profileRepository.updateUser(updatedUser);
    }
  }

  Future<void> _onProfileChangePassword(
    ProfileChangePassword event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(token: event.password));
    final user = await _profileRepository.getUser();
    if (user != null) {
      final updatedUser = user.copyWith(token: event.password);
      await _profileRepository.updateUser(updatedUser);
    }
  }

  Future<void> _onProfileChangePhone(
    ProfileChangePhone event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(phone: event.phone));
    final user = await _profileRepository.getUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        userId: event.phone,
      ); // UserModel'de phone alanı yoksa userId kullanılıyor, gerekirse UserModel'e phone ekle.
      await _profileRepository.updateUser(updatedUser);
    }
  }

  Future<void> _onProfileChangeImage(
    ProfileChangeImage event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(photo: event.imagePath));
    final user = await _profileRepository.getUser();
    if (user != null) {
      final updatedUser = user.copyWith(photo: event.imagePath);
      await _profileRepository.updateUser(updatedUser);
    }
  }

  Future<void> _onProfileLogout(
    ProfileLogout event,
    Emitter<ProfileState> emit,
  ) async {
    await _profileRepository.deleteUser();
    emit(state.copyWith(isLoggedIn: false));
  }

  Future<void> _onProfileDelete(
    ProfileDelete event,
    Emitter<ProfileState> emit,
  ) async {
    await _profileRepository.deleteUser();
    emit(state.copyWith(isLoggedIn: false));
  }
}
