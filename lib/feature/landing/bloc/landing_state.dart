part of 'landing_bloc.dart';

class LandingState extends Equatable {
  final bool isLoading;
  final bool isInitialized;
  final bool userChecked;
  final String? navigationPath;
  
  const LandingState({
    this.isLoading = false,
    this.isInitialized = false,
    this.userChecked = false,
    this.navigationPath,
  });
  
  LandingState copyWith({
    bool? isLoading,
    bool? isInitialized,
    bool? userChecked,
    String? navigationPath,
  }) {
    return LandingState(
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
      userChecked: userChecked ?? this.userChecked,
      navigationPath: navigationPath ?? this.navigationPath,
    );
  }
  
  @override
  List<Object?> get props => [isLoading, isInitialized, userChecked, navigationPath];
}
