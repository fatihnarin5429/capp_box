// create_capsule_bloc.dart

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_body_model.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsule_datasources.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsules_usecases.dart';

import 'package:capp_box/product/database/hive/core/hive_database_manager.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:capp_box/product/utility/enums/status_enum.dart';
import 'package:equatable/equatable.dart';

part 'create_capsule_event.dart';
part 'create_capsule_state.dart';

class CreateCapsuleBloc extends Bloc<CreateCapsuleEvent, CreateCapsuleState> {
  final CreateCapsulesRemoteDatasource createCapsuleRemoteDatasource;
  late final CreateCapsulesUsecase createCapsulesUsecase;

  CreateCapsuleBloc()
    : createCapsuleRemoteDatasource = CreateCapsulesRemoteDatasource(),
      super(const CreateCapsuleState()) {
    createCapsulesUsecase = CreateCapsulesUsecase(
      createCapsuleRemoteDatasource,
    );
    on<CreateCapsuleBodyAction>(onCreateCapsuleBodyAction);
    // on<CreateCapsuleResponseAction>(onCreateCapsuleResponseAction);
    on<CreateCapsuleMediaTypeAction>(onCreateCapsuleMediaTypeAction);
    on<CreateCapsuleSubmitAction>(onCreateCapsuleSubmitAction);

    // Media Selection Events
    on<PickMediaEvent>(onPickMediaEvent);
    on<MediaSelectedEvent>(onMediaSelectedEvent);
    on<ClearMediaEvent>(onClearMediaEvent);
    on<StartPhotoEditEvent>(onStartPhotoEditEvent);
    on<StopPhotoEditEvent>(onStopPhotoEditEvent);
    on<StartTextEditEvent>(onStartTextEditEvent);
    on<StopTextEditEvent>(onStopTextEditEvent);
    on<UpdateTextContentEvent>(onUpdateTextContentEvent);
    on<PhotoSavedEvent>(onPhotoSavedEvent);
  }

  HiveDatabaseManager hiveDatabaseManager = HiveDatabaseManager();

  Future<void> onCreateCapsuleBodyAction(
    CreateCapsuleBodyAction event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    emit(
      state.copyWith(
        status: StatusEnum.loading,
        createCapsuleBodyModel: event.createCapsuleBodyModel,
      ),
    );
    print(state.createCapsuleBodyModel.toJson());
  }

  // Future<void> onCreateCapsuleResponseAction(
  //   CreateCapsuleResponseAction event,
  //   Emitter<CreateCapsuleState> emit,
  // ) async {
  //   final response = await createCapsulesUsecase.createCapsule(
  //     createCapsuleBodyModel: state.createCapsuleBodyModel,
  //   );
  //   print(response.toJson());
  //   if (response.data != null) {
  //     emit(state.copyWith(status: StatusEnum.success));
  //   } else {
  //     emit(state.copyWith(status: StatusEnum.error));
  //   }
  //   emit(
  //     state.copyWith(
  //       status: StatusEnum.loading,
  //       createCapsuleResponseModel: event.createCapsuleResponseModel,
  //     ),
  //   );
  // }

  Future<void> onCreateCapsuleSubmitAction(
    CreateCapsuleSubmitAction event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    final userModel = await hiveDatabaseManager.getUserModel();
    print('tokenennnnn ${userModel?.token}');
    emit(state.copyWith(status: StatusEnum.loading));
    try {
      final response = await createCapsulesUsecase.createCapsule(
        createCapsuleBodyModel: state.createCapsuleBodyModel,
        token: userModel?.token ?? '',
      );

      if (response != null) {
        emit(
          state.copyWith(
            status: StatusEnum.success,
            createCapsuleResponseModel: response,
          ),
        );
      } else {
        emit(state.copyWith(status: StatusEnum.error));
        BotToast.showText(text: 'Kapsül oluşturulamadı.');
      }
    } catch (e) {
      emit(state.copyWith(status: StatusEnum.error));
      BotToast.showText(text: 'Kapsül oluştururken hata: $e');
    }
  }

  Future<void> onCreateCapsuleMediaTypeAction(
    CreateCapsuleMediaTypeAction event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    emit(state.copyWith(mediaType: event.mediaType));
  }

  // Media Selection Event Handlers
  Future<void> onPickMediaEvent(
    PickMediaEvent event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    if (state.mediaType == MediaType.text) {
      emit(state.copyWith(isEditingText: true));
      return;
    }

    emit(state.copyWith(isLoading: true));
  }

  Future<void> onMediaSelectedEvent(
    MediaSelectedEvent event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    emit(
      state
          .copyWithSelectedFile(event.file, event.fileName)
          .copyWith(
            isLoading: false,
            isEditingPhoto: state.mediaType == MediaType.photo,
          ),
    );
  }

  Future<void> onClearMediaEvent(
    ClearMediaEvent event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    emit(
      state
          .copyWithSelectedFile(null, null)
          .copyWith(isEditingPhoto: false, isEditingText: false),
    );
  }

  Future<void> onStartPhotoEditEvent(
    StartPhotoEditEvent event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    emit(state.copyWith(isEditingPhoto: true));
  }

  Future<void> onStopPhotoEditEvent(
    StopPhotoEditEvent event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    emit(state.copyWith(isEditingPhoto: false));
  }

  Future<void> onStartTextEditEvent(
    StartTextEditEvent event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    emit(state.copyWith(isEditingText: true));
  }

  Future<void> onStopTextEditEvent(
    StopTextEditEvent event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    emit(state.copyWith(isEditingText: false));
  }

  Future<void> onUpdateTextContentEvent(
    UpdateTextContentEvent event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    emit(state.copyWith(textContent: event.text));
  }

  Future<void> onPhotoSavedEvent(
    PhotoSavedEvent event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    emit(
      state
          .copyWithSelectedFile(
            event.editedFile,
            event.editedFile.path.split('/').last,
          )
          .copyWith(isEditingPhoto: false),
    );
  }
}
