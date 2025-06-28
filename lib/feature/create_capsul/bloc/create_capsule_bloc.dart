// create_capsule_bloc.dart

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:capp_box/product/database/hive/core/hive_database_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsule_datasources.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsule_repository.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsules_usecases.dart';

part 'create_capsule_event.dart';
part 'create_capsule_state.dart';

class CreateCapsuleBloc extends Bloc<CreateCapsuleEvent, CreateCapsuleState> {
  final CreateCapsulesRemoteDatasource createCapsuleRemoteDatasource;
  late final CreateCapsulesUsecase createCapsuleUsecase;

  CreateCapsuleBloc()
    : createCapsuleRemoteDatasource = CreateCapsulesRemoteDatasource(),

      super(const CreateCapsuleState()) {
    createCapsuleUsecase = CreateCapsulesUsecase(createCapsuleRemoteDatasource);
    on<CreateCapsuleAction>(_onCreateCapsuleAction);
    on<AddCreatedCapsules>(_onAddCreatedCapsules);
    on<ResetCreateCapsuleModel>(_onResetCreateCapsuleModel);
  }
  HiveDatabaseManager hiveDatabaseManager = HiveDatabaseManager();
  Future<void> _onCreateCapsuleAction(
    CreateCapsuleAction event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    try {
      emit(state.copyWith(createCapsuleModel: event.createCapsuleModel));
      // Usecase ile kapsül oluştur
      final result = await createCapsuleUsecase.createCapsule(
        event.createCapsuleModel,
        title: event.createCapsuleModel.title ?? '',
        message: event.createCapsuleModel.message ?? '',
        email: event.createCapsuleModel.email ?? '',
        phone: event.createCapsuleModel.phoneNumber ?? '',
        price: event.createCapsuleModel.price ?? '',
      );

      // Local database'e kaydet
      hiveDatabaseManager.saveCapsuleModel(result);
      emit(state.copyWith(createCapsuleModel: result));
    } catch (e) {
      // Hata durumunda state güncelle
      emit(state.copyWith());
    }
  }

  Future<void> _onAddCreatedCapsules(
    AddCreatedCapsules event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    List<CreateCapsuleModel> updatedCapsules = [
      ...state.myCreatedCapsules,
      event.createCapsuleModel,
    ];
    emit(
      state.copyWith(
        myCreatedCapsules: updatedCapsules,
        filteredCapsules: updatedCapsules, // Also update filtered capsules
      ),
    );
  }

  void _onResetCreateCapsuleModel(
    ResetCreateCapsuleModel event,
    Emitter<CreateCapsuleState> emit,
  ) {
    emit(state.copyWith(createCapsuleModel: const CreateCapsuleModel()));
  }
}
