part of 'create_capsule_bloc.dart';

abstract class CreateCapsuleEvent extends Equatable {
  const CreateCapsuleEvent();

  @override
  List<Object?> get props => [];
}

class CreateCapsuleBodyAction extends CreateCapsuleEvent {
  final CreateCapsuleBodyModel createCapsuleBodyModel;
  const CreateCapsuleBodyAction(this.createCapsuleBodyModel);
  @override
  List<Object?> get props => [createCapsuleBodyModel];
}

class CreateCapsuleResponseAction extends CreateCapsuleEvent {
  final CreateCapsuleResponseModel createCapsuleResponseModel;
  const CreateCapsuleResponseAction(this.createCapsuleResponseModel);
  @override
  List<Object?> get props => [createCapsuleResponseModel];
}

class CreateCapsuleMediaTypeAction extends CreateCapsuleEvent {
  final MediaType mediaType;
  const CreateCapsuleMediaTypeAction(this.mediaType);
  @override
  List<Object?> get props => [mediaType];
}

class CreateCapsuleSubmitAction extends CreateCapsuleEvent {
  const CreateCapsuleSubmitAction();
  @override
  List<Object?> get props => [];
}