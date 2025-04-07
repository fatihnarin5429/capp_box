// create_capsule_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';

part 'create_capsule_event.dart';
part 'create_capsule_state.dart';

class CreateCapsuleBloc extends Bloc<CreateCapsuleEvent, CreateCapsuleState> {
  CreateCapsuleBloc() : super(CreateCapsuleState()) {
    on<CreateCapsuleAction>(_onCreateCapsuleAction);
    on<AddCreatedCapsules>(_onAddCreatedCapsules);
    on<ResetCreateCapsuleModel>(_onResetCreateCapsuleModel);
    on<FilterCapsules>(_onFilterCapsules);

    // Initialize filtered capsules with all capsules
    add(const FilterCapsules(filterIndex: 0));
  }

  void _onCreateCapsuleAction(
    CreateCapsuleAction event,
    Emitter<CreateCapsuleState> emit,
  ) {
    emit(state.copyWith(createCapsuleModel: event.createCapsuleModel));
    print(state.createCapsuleModel);
  }

  Future<void> _onAddCreatedCapsules(
    AddCreatedCapsules event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    final updatedCapsules = [
      ...state.myCreatedCapsules,
      event.createCapsuleModel
    ];
    emit(
      state.copyWith(
        createdCapsules: updatedCapsules,
        filteredCapsules: updatedCapsules, // Also update filtered capsules
      ),
    );
    print('created capsuless${state.myCreatedCapsules}');
  }

  void _onResetCreateCapsuleModel(
    ResetCreateCapsuleModel event,
    Emitter<CreateCapsuleState> emit,
  ) {
    emit(state.copyWith(createCapsuleModel: const CreateCapsuleModel()));
  }

  void _onFilterCapsules(
    FilterCapsules event,
    Emitter<CreateCapsuleState> emit,
  ) {
    final now = DateTime.now().millisecondsSinceEpoch;

    switch (event.filterIndex) {
      case 0: // Tümü
        // Hem gönderilen hem oluşturulan tüm kapsüller
        emit(state.copyWith(
          filteredCapsules: [
            ...state.receivedCapsules,
            ...state.myCreatedCapsules
          ],
        ));
        break;

      case 1: // Yakında
        // Sadece bana gönderilen ve açılma tarihi gelecekte olan kapsüller
        final soonToOpen = state.receivedCapsules.where((capsule) {
          final openDate = int.tryParse(capsule.openedDate ?? '');
          return openDate != null && openDate > now;
        }).toList();

        emit(state.copyWith(filteredCapsules: soonToOpen));
        break;

      case 2: // Hazır
        // Sadece bana gönderilen ve açılma tarihi geçmiş olan kapsüller
        final readyToOpen = state.receivedCapsules.where((capsule) {
          final openDate = int.tryParse(capsule.openedDate ?? '');
          return openDate != null && openDate <= now;
        }).toList();

        emit(state.copyWith(filteredCapsules: readyToOpen));
        break;

      case 3: // Kapsüllerim
        // Zaten view'da myCreatedCapsules kullanılıyor
        break;
    }
  }
}
