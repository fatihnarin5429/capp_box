part of 'create_capsule_bloc.dart';

final class CreateCapsuleState extends Equatable {
  const CreateCapsuleState({
    this.createCapsuleModel = const CreateCapsuleModel(),
    this.myCreatedCapsules = const [],
    this.filteredCapsules = const [],
    this.receivedCapsules = const [],
  });
  final CreateCapsuleModel createCapsuleModel;
  final List<CreateCapsuleModel> myCreatedCapsules;
  final List<CreateCapsuleModel> filteredCapsules;
  final List<CreateCapsuleModel> receivedCapsules;

  @override
  List<Object?> get props => [
        createCapsuleModel,
        myCreatedCapsules,
        filteredCapsules,
        receivedCapsules,
      ];

  CreateCapsuleState copyWith({
    CreateCapsuleModel? createCapsuleModel,
    List<CreateCapsuleModel>? myCreatedCapsules,
    List<CreateCapsuleModel>? filteredCapsules,
    List<CreateCapsuleModel>? receivedCapsules,
  }) {
    return CreateCapsuleState(
      createCapsuleModel: createCapsuleModel ?? this.createCapsuleModel,
      myCreatedCapsules: myCreatedCapsules ?? this.myCreatedCapsules,
      filteredCapsules: filteredCapsules ?? this.filteredCapsules,
      receivedCapsules: receivedCapsules ?? this.receivedCapsules,
    );
  }
}
