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

// Media Selection Events
class PickMediaEvent extends CreateCapsuleEvent {
  const PickMediaEvent();
  @override
  List<Object?> get props => [];
}

class MediaSelectedEvent extends CreateCapsuleEvent {
  final File file;
  final String fileName;
  const MediaSelectedEvent(this.file, this.fileName);
  @override
  List<Object?> get props => [file, fileName];
}

class ClearMediaEvent extends CreateCapsuleEvent {
  const ClearMediaEvent();
  @override
  List<Object?> get props => [];
}

class StartPhotoEditEvent extends CreateCapsuleEvent {
  const StartPhotoEditEvent();
  @override
  List<Object?> get props => [];
}

class StopPhotoEditEvent extends CreateCapsuleEvent {
  const StopPhotoEditEvent();
  @override
  List<Object?> get props => [];
}

class StartTextEditEvent extends CreateCapsuleEvent {
  const StartTextEditEvent();
  @override
  List<Object?> get props => [];
}

class StopTextEditEvent extends CreateCapsuleEvent {
  const StopTextEditEvent();
  @override
  List<Object?> get props => [];
}

class UpdateTextContentEvent extends CreateCapsuleEvent {
  final String text;
  const UpdateTextContentEvent(this.text);
  @override
  List<Object?> get props => [text];
}

class PhotoSavedEvent extends CreateCapsuleEvent {
  final File editedFile;
  const PhotoSavedEvent(this.editedFile);
  @override
  List<Object?> get props => [editedFile];
}
