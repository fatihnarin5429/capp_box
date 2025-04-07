part of 'create_capsule_bloc.dart';

abstract class CreateCapsuleEvent extends Equatable {
  const CreateCapsuleEvent();

  @override
  List<Object?> get props => [];
}

class CreateCapsuleAction extends CreateCapsuleEvent {
  final CreateCapsuleModel createCapsuleModel;

  const CreateCapsuleAction({required this.createCapsuleModel});

  @override
  List<Object?> get props => [createCapsuleModel];
}

class AddCreatedCapsules extends CreateCapsuleEvent {
  final CreateCapsuleModel createCapsuleModel;

  const AddCreatedCapsules({required this.createCapsuleModel});

  @override
  List<Object?> get props => [createCapsuleModel];
}

class ResetCreateCapsuleModel extends CreateCapsuleEvent {
  @override
  List<Object?> get props => [];
}

class FilterCapsules extends CreateCapsuleEvent {
  final int filterIndex;

  const FilterCapsules({required this.filterIndex});

  @override
  List<Object?> get props => [filterIndex];
}
