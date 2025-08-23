part of 'create_capsule_bloc.dart';

final class CreateCapsuleState extends Equatable {
  final StatusEnum status;
  final CreateCapsuleBodyModel createCapsuleBodyModel;
  final CreateCapsuleResponseModel? createCapsuleResponseModel;
  final MediaType? mediaType;

  // Media Selection State
  final File? selectedFile;
  final String? selectedFileName;
  final bool isLoading;
  final bool isEditingPhoto;
  final bool isEditingText;
  final String textContent;

  const CreateCapsuleState({
    this.status = StatusEnum.loading,
    this.createCapsuleBodyModel = const CreateCapsuleBodyModel(),
    this.createCapsuleResponseModel,
    this.mediaType,
    this.selectedFile,
    this.selectedFileName,
    this.isLoading = false,
    this.isEditingPhoto = false,
    this.isEditingText = false,
    this.textContent = '',
  });

  bool get hasMedia =>
      selectedFile != null ||
      (mediaType == MediaType.text && textContent.isNotEmpty);

  CreateCapsuleState copyWith({
    StatusEnum? status,
    CreateCapsuleBodyModel? createCapsuleBodyModel,
    CreateCapsuleResponseModel? createCapsuleResponseModel,
    MediaType? mediaType,
    File? selectedFile,
    String? selectedFileName,
    bool? isLoading,
    bool? isEditingPhoto,
    bool? isEditingText,
    String? textContent,
  }) {
    return CreateCapsuleState(
      status: status ?? this.status,
      createCapsuleBodyModel:
          createCapsuleBodyModel ?? this.createCapsuleBodyModel,
      createCapsuleResponseModel:
          createCapsuleResponseModel ?? this.createCapsuleResponseModel,
      mediaType: mediaType ?? this.mediaType,
      selectedFile: selectedFile,
      selectedFileName: selectedFileName,
      isLoading: isLoading ?? this.isLoading,
      isEditingPhoto: isEditingPhoto ?? this.isEditingPhoto,
      isEditingText: isEditingText ?? this.isEditingText,
      textContent: textContent ?? this.textContent,
    );
  }

  // Helper methods for specific state updates
  CreateCapsuleState copyWithSelectedFile(File? file, String? fileName) {
    return CreateCapsuleState(
      status: status,
      createCapsuleBodyModel: createCapsuleBodyModel,
      createCapsuleResponseModel: createCapsuleResponseModel,
      mediaType: mediaType,
      selectedFile: file,
      selectedFileName: fileName,
      isLoading: isLoading,
      isEditingPhoto: isEditingPhoto,
      isEditingText: isEditingText,
      textContent: textContent,
    );
  }

  @override
  List<Object?> get props => [
    status,
    createCapsuleBodyModel,
    createCapsuleResponseModel,
    mediaType,
    selectedFile,
    selectedFileName,
    isLoading,
    isEditingPhoto,
    isEditingText,
    textContent,
  ];
}
