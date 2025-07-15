// create_capsule_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsule_datasources.dart';
import 'package:capp_box/feature/create_capsul/services/model/create_capsules_usecases.dart';

part 'create_capsule_event.dart';
part 'create_capsule_state.dart';

class CreateCapsuleBloc extends Bloc<CreateCapsuleEvent, CreateCapsuleState> {
  final CreateCapsulesRemoteDatasource createCapsuleRemoteDatasource;
  late final CreateCapsulesUsecase createCapsuleUsecase;

  CreateCapsuleBloc()
    : createCapsuleRemoteDatasource = CreateCapsulesRemoteDatasource(),
      super(
        CreateCapsuleState(
          CreateCapsuleResponseModel(
            recipientPhone: '',
            recipientEmail: '',
            openDate: '',
            price: 0,
            success: false,
            message: '',
            data: CapsuleData(
              capsule: Capsule(
                title: '',
                message: '',
                sender: '',
                recipientEmail: '',
                recipientPhone: '',
                recipientUser: '',
                isClaimed: false,
                openDate: DateTime.now(),
                isOpened: false,
                price: 0,
                paymentStatus: '',
                notificationSentToUnregistered: false,
                notificationSentToRegistered: false,
                id: '',
                media: [],
                createdAt: DateTime.now(),
                v: 0,
              ),
              paymentId: '',
            ),
          ),
        ),
      ) {
    createCapsuleUsecase = CreateCapsulesUsecase(createCapsuleRemoteDatasource);
    on<CreateCapsuleAction>(_onCreateCapsuleAction);
    on<AddCreatedCapsules>(_onAddCreatedCapsules);
    on<ResetCreateCapsuleResponseModel>(_onResetCreateCapsuleResponseModel);
  }

  Future<void> _onCreateCapsuleAction(
    CreateCapsuleAction event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          createCapsuleResponseModel: event.createCapsuleResponseModel,
        ),
      );
      // Usecase ile kapsül oluştur
      final _ = await createCapsuleUsecase.createCapsule(
        title: event.createCapsuleResponseModel.data.capsule.title,
        message: event.createCapsuleResponseModel.message,
        recipientEmail: event.createCapsuleResponseModel.recipientEmail,
        recipientPhone: event.createCapsuleResponseModel.recipientPhone,
        openDate: event.createCapsuleResponseModel.openDate,
        price: event.createCapsuleResponseModel.price,
      );
      // Sonuç kullanılmıyor, istersen burada emit ile state güncelleyebilirsin.
    } catch (e) {
      // log(e.toString()); // log kullanılmıyor, print de önerilmez, hata yönetimi eklenebilir.
    }
  }

  Future<void> _onAddCreatedCapsules(
    AddCreatedCapsules event,
    Emitter<CreateCapsuleState> emit,
  ) async {
    List<CreateCapsuleResponseModel> updatedCapsules = [
      ...state.myCreatedCapsules,
      event.createCapsuleResponseModel,
    ];
    emit(
      state.copyWith(
        myCreatedCapsules: updatedCapsules,
        filteredCapsules: updatedCapsules, // Also update filtered capsules
      ),
    );
  }

  void _onResetCreateCapsuleResponseModel(
    ResetCreateCapsuleResponseModel event,
    Emitter<CreateCapsuleState> emit,
  ) {
    emit(
      state.copyWith(
        createCapsuleResponseModel: CreateCapsuleResponseModel(
          data: CapsuleData(
            capsule: Capsule(
              sender: '',
              title: '',
              message: '',
              recipientEmail: '',
              recipientPhone: '',
              recipientUser: '',
              isClaimed: false,
              openDate: DateTime.now(),
              isOpened: false,
              price: 0,
              paymentStatus: '',
              notificationSentToUnregistered: false,
              notificationSentToRegistered: false,
              id: '',
              media: [],
              createdAt: DateTime.now(),
              v: 0,
            ),
            paymentId: '',
          ),
          message: '',
          success: false,
          recipientPhone: '',
          recipientEmail: '',
          openDate: '',
          price: 0,
        ),
      ),
    );
  }
}
