part of 'capsule_bloc.dart';

enum CapsuleStatus { initial, loading, loaded, error }

class CapsuleState extends Equatable {
  const CapsuleState({
    this.status = CapsuleStatus.initial,
    this.capsules = const [],
    this.filteredCapsules = const [],
    this.searchQuery = '',
    this.filterType = '',
    this.sortBy = '',
    this.selectedCapsuleId = '',
    this.error,
  });

  final CapsuleStatus status;
  final List<dynamic> capsules;
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

  CapsuleState copyWith({
    CapsuleStatus? status,
    List<dynamic>? capsules,
    List<dynamic>? filteredCapsules,
    String? searchQuery,
    String? filterType,
    String? sortBy,
    String? selectedCapsuleId,
    String? error,
  }) {
    return CapsuleState(
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
