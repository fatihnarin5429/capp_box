import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/home/service/capsule_service.dart';
import 'package:capp_box/feature/home/model/capsule_model.dart';

part 'capsule_event.dart';
part 'capsule_state.dart';

class CapsuleBloc extends Bloc<CapsuleEvent, CapsuleState> {
  final CapsuleService _capsuleService;

  CapsuleBloc({required CapsuleService capsuleService})
      : _capsuleService = capsuleService,
        super(const CapsuleState()) {
    on<CapsuleLoad>(_onCapsuleLoad);
    on<CapsuleRefresh>(_onCapsuleRefresh);
    on<CapsuleSearch>(_onCapsuleSearch);
    on<CapsuleFilter>(_onCapsuleFilter);
    on<CapsuleSort>(_onCapsuleSort);
    on<CapsuleFavorite>(_onCapsuleFavorite);
    on<CapsuleDelete>(_onCapsuleDelete);
    on<CapsuleView>(_onCapsuleView);
  }

  Future<void> _onCapsuleLoad(
    CapsuleLoad event,
    Emitter<CapsuleState> emit,
  ) async {
    emit(state.copyWith(status: CapsuleStatus.loading));
    try {
      final capsules = await _capsuleService.getUpcomingCapsules();
      emit(state.copyWith(
        status: CapsuleStatus.loaded,
        capsules: capsules,
      ));
    } catch (e) {
      emit(state.copyWith(status: CapsuleStatus.error, error: e.toString()));
    }
  }

  Future<void> _onCapsuleRefresh(
    CapsuleRefresh event,
    Emitter<CapsuleState> emit,
  ) async {
    emit(state.copyWith(status: CapsuleStatus.loading));
    try {
      final capsules = await _capsuleService.getUpcomingCapsules();
      emit(state.copyWith(
        status: CapsuleStatus.loaded,
        capsules: capsules,
      ));
    } catch (e) {
      emit(state.copyWith(status: CapsuleStatus.error, error: e.toString()));
    }
  }

  Future<void> _onCapsuleSearch(
    CapsuleSearch event,
    Emitter<CapsuleState> emit,
  ) async {
    final searchQuery = event.searchQuery.toLowerCase();
    final filteredCapsules = state.capsules.where((capsule) {
      return capsule.title.toLowerCase().contains(searchQuery) ||
          capsule.content.toLowerCase().contains(searchQuery);
    }).toList();

    emit(state.copyWith(
      searchQuery: event.searchQuery,
      filteredCapsules: filteredCapsules,
    ));
  }

  Future<void> _onCapsuleFilter(
    CapsuleFilter event,
    Emitter<CapsuleState> emit,
  ) async {
    emit(state.copyWith(filterType: event.filterType));
    // Implement filtering logic based on filterType
  }

  Future<void> _onCapsuleSort(
    CapsuleSort event,
    Emitter<CapsuleState> emit,
  ) async {
    emit(state.copyWith(sortBy: event.sortBy));
    // Implement sorting logic based on sortBy
  }

  Future<void> _onCapsuleFavorite(
    CapsuleFavorite event,
    Emitter<CapsuleState> emit,
  ) async {
    // Update favorite status logic here
    // Update the capsule in the database
  }

  Future<void> _onCapsuleDelete(
    CapsuleDelete event,
    Emitter<CapsuleState> emit,
  ) async {
    try {
      await _capsuleService.deleteCapsule(event.capsuleId);

      // Remove the deleted capsule from the state
      final updatedCapsules = state.capsules
          .where((capsule) => capsule.id != event.capsuleId)
          .toList();

      emit(state.copyWith(capsules: updatedCapsules));
    } catch (e) {
      emit(state.copyWith(status: CapsuleStatus.error, error: e.toString()));
    }
  }

  Future<void> _onCapsuleView(
    CapsuleView event,
    Emitter<CapsuleState> emit,
  ) async {
    emit(state.copyWith(selectedCapsuleId: event.capsuleId));
  }
}
