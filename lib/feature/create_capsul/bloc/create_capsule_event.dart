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

class RegisterAction extends CreateCapsuleEvent {
  final String title;
  final String message;
  final String email;
  final String phone;
  final String price;

  const RegisterAction({
    required this.title,
    required this.message,
    required this.email,
    required this.phone,
    required this.price,
  });

  @override
  List<Object?> get props => [title, message, email, phone, price];
}

class ResetCreateCapsuleModel extends CreateCapsuleEvent {
  const ResetCreateCapsuleModel();

  @override
  List<Object?> get props => [];
}
