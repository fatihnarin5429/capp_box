import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<ProfileChangeName>(_onProfileChangeName);
    on<ProfileChangeEmail>(_onProfileChangeEmail);
    on<ProfileChangePassword>(_onProfileChangePassword);
    on<ProfileChangePhone>(_onProfileChangePhone);
    on<ProfileChangeImage>(_onProfileChangeImage);
  }

  Future<void> _onProfileChangeName(
    ProfileChangeName event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(displayName: event.displayName));
  }

  Future<void> _onProfileChangeEmail(
    ProfileChangeEmail event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _onProfileChangePassword(
      ProfileChangePassword event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onProfileChangePhone(
    ProfileChangePhone event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onProfileChangeImage(
    ProfileChangeImage event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(imagePath: event.imagePath));
  }
}
