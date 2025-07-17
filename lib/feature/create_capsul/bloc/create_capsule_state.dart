part of 'create_capsule_bloc.dart';

final class CreateCapsuleState extends Equatable {
  final StatusEnum status;
  final CreateCapsuleBodyModel createCapsuleBodyModel;
  final CreateCapsuleResponseModel? createCapsuleResponseModel;
  final MediaType? mediaType;

  const CreateCapsuleState({
    this.status = StatusEnum.loading,
    this.createCapsuleBodyModel = const CreateCapsuleBodyModel(),
    this.createCapsuleResponseModel,
    this.mediaType,
  });

  CreateCapsuleState copyWith({
    StatusEnum? status,
    CreateCapsuleBodyModel? createCapsuleBodyModel,
    CreateCapsuleResponseModel? createCapsuleResponseModel,
    MediaType? mediaType,
  }) {
    return CreateCapsuleState(
      status: status ?? this.status,
      createCapsuleBodyModel: createCapsuleBodyModel ?? this.createCapsuleBodyModel,
      createCapsuleResponseModel: createCapsuleResponseModel ?? this.createCapsuleResponseModel,
      mediaType: mediaType ?? this.mediaType,
    );
  }

  @override
  List<Object?> get props => [
    status,
    createCapsuleBodyModel,
    createCapsuleResponseModel,
    mediaType,
  ];
}
