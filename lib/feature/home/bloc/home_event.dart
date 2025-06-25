part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeGetCapsules extends HomeEvent {
  const HomeGetCapsules();
}

class CapsuleLoad extends HomeEvent {
  const CapsuleLoad();
}

class CapsuleRefresh extends HomeEvent {
  const CapsuleRefresh();
}

class CapsuleSearch extends HomeEvent {
  final String searchQuery;
  const CapsuleSearch({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

class CapsuleFilter extends HomeEvent {
  final String filterType;
  const CapsuleFilter({required this.filterType});

  @override
  List<Object> get props => [filterType];
}

class CapsuleSort extends HomeEvent {
  final String sortBy;
  const CapsuleSort({required this.sortBy});

  @override
  List<Object> get props => [sortBy];
}

class CapsuleFavorite extends HomeEvent {
  final String capsuleId;
  final bool isFavorite;
  const CapsuleFavorite({required this.capsuleId, required this.isFavorite});

  @override
  List<Object> get props => [capsuleId, isFavorite];
}

class CapsuleDelete extends HomeEvent {
  final String capsuleId;
  const CapsuleDelete({required this.capsuleId});

  @override
  List<Object> get props => [capsuleId];
}

class CapsuleView extends HomeEvent {
  final String capsuleId;
  const CapsuleView({required this.capsuleId});

  @override
  List<Object> get props => [capsuleId];
}
