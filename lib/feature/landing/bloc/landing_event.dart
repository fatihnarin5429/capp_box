part of 'landing_bloc.dart';

abstract class LandingEvent extends Equatable {
  const LandingEvent();

  @override
  List<Object?> get props => [];
}

class LandingInitializeEvent extends LandingEvent {}

class LandingCheckUserEvent extends LandingEvent {}
