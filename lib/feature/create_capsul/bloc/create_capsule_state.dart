part of 'create_capsule_bloc.dart';

final class CreateCapsuleState extends Equatable {
  final CreateCapsuleResponseModel createCapsuleResponseModel;
  final List<CreateCapsuleResponseModel> myCreatedCapsules;
  final List<CreateCapsuleResponseModel> filteredCapsules;

  const CreateCapsuleState(
    this.createCapsuleResponseModel, {
    this.myCreatedCapsules = const [],
    this.filteredCapsules = const [],
  });

  CreateCapsuleState copyWith({
    CreateCapsuleResponseModel? createCapsuleResponseModel,
    List<CreateCapsuleResponseModel>? myCreatedCapsules,
    List<CreateCapsuleResponseModel>? filteredCapsules,
  }) {
    return CreateCapsuleState(
      createCapsuleResponseModel ?? this.createCapsuleResponseModel,
      myCreatedCapsules: myCreatedCapsules ?? this.myCreatedCapsules,
      filteredCapsules: filteredCapsules ?? this.filteredCapsules,
    );
  }

  @override
  List<Object?> get props => [
    createCapsuleResponseModel,
    myCreatedCapsules,
    filteredCapsules,
  ];
}
