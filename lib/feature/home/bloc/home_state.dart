part of 'home_bloc.dart';

enum CapsuleStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  const HomeState({
    this.status = CapsuleStatus.initial,
    this.capsules,
    this.filteredCapsules = const [],
    this.searchQuery = '',
    this.filterType = '',
    this.sortBy = '',
    this.selectedCapsuleId = '',
    this.error,
  });

  final CapsuleStatus status;
  final List<CapsuleModel>? capsules;
  final List<dynamic> filteredCapsules;
  final String searchQuery;
  final String filterType;
  final String sortBy;
  final String selectedCapsuleId;
  final String? error;

  @override
  List<Object?> get props => [
    status,
    capsules,
    filteredCapsules,
    searchQuery,
    filterType,
    sortBy,
    selectedCapsuleId,
    error,
  ];

  HomeState copyWith({
    CapsuleStatus? status,
    List<CapsuleModel>? capsules,
    List<dynamic>? filteredCapsules,
    String? searchQuery,
    String? filterType,
    String? sortBy,
    String? selectedCapsuleId,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      capsules: capsules ?? this.capsules,
      filteredCapsules: filteredCapsules ?? this.filteredCapsules,
      searchQuery: searchQuery ?? this.searchQuery,
      filterType: filterType ?? this.filterType,
      sortBy: sortBy ?? this.sortBy,
      selectedCapsuleId: selectedCapsuleId ?? this.selectedCapsuleId,
      error: error ?? this.error,
    );
  }
}
