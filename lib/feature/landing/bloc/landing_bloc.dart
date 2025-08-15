import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:capp_box/product/database/hive/core/hive_database_manager.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  final HiveDatabaseManager hiveDatabaseManager = HiveDatabaseManager();

  LandingBloc() : super(const LandingState()) {
    on<LandingInitializeEvent>(_onLandingInitializeEvent);
    on<LandingCheckUserEvent>(_onLandingCheckUserEvent);
  }

  Future<void> _onLandingInitializeEvent(
    LandingInitializeEvent event,
    Emitter<LandingState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await hiveDatabaseManager.init();

      emit(state.copyWith(isLoading: false, isInitialized: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onLandingCheckUserEvent(
    LandingCheckUserEvent event,
    Emitter<LandingState> emit,
  ) async {
    try {
      final user = await hiveDatabaseManager.getUserModel();
      print('user: $user');

      if (user != null && user.token?.isNotEmpty == true) {
        emit(state.copyWith(userChecked: true, navigationPath: '/login'));
      } else {
        emit(state.copyWith(userChecked: true, navigationPath: '/login'));
      }
    } catch (e) {
      emit(state.copyWith(userChecked: true, navigationPath: '/login'));
    }
  }
}
