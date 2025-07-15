part of 'create_capsule_bloc.dart';

abstract class CreateCapsuleEvent extends Equatable {
  const CreateCapsuleEvent();

  @override
  List<Object?> get props => [];
}

class CreateCapsuleAction extends CreateCapsuleEvent {
  final CreateCapsuleResponseModel createCapsuleResponseModel;
  const CreateCapsuleAction(this.createCapsuleResponseModel);

  @override
  List<Object?> get props => [createCapsuleResponseModel];
}

class AddCreatedCapsules extends CreateCapsuleEvent {
  final CreateCapsuleResponseModel createCapsuleResponseModel;
  const AddCreatedCapsules(this.createCapsuleResponseModel);
  @override
  List<Object?> get props => [createCapsuleResponseModel];
}

class RegisterAction extends CreateCapsuleEvent {
  final String title;
  final String message;
  final String recipientEmail;
  final String openDate;
  final String recipientPhone;
  final int price;

  const RegisterAction({
    required this.title,
    required this.message,
    required this.openDate,
    required this.recipientEmail,
    required this.recipientPhone,
    required this.price,
  });

  @override
  List<Object?> get props => [
    title,
    message,
    recipientEmail,
    recipientPhone,
    price,
  ];
}

class ResetCreateCapsuleResponseModel extends CreateCapsuleEvent {}
