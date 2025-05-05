part of 'capsule_bloc.dart';

sealed class CapsuleEvent extends Equatable {
  const CapsuleEvent();

  @override
  List<Object> get props => [];
}

class CapsuleLoad extends CapsuleEvent {
  const CapsuleLoad();
}

class CapsuleRefresh extends CapsuleEvent {
  const CapsuleRefresh();
}

class CapsuleSearch extends CapsuleEvent {
  final String searchQuery;
  const CapsuleSearch({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

class CapsuleFilter extends CapsuleEvent {
  final String filterType;
  const CapsuleFilter({required this.filterType});

  @override
  List<Object> get props => [filterType];
}

class CapsuleSort extends CapsuleEvent {
  final String sortBy;
  const CapsuleSort({required this.sortBy});

  @override
  List<Object> get props => [sortBy];
}

class CapsuleFavorite extends CapsuleEvent {
  final String capsuleId;
  final bool isFavorite;
  const CapsuleFavorite({required this.capsuleId, required this.isFavorite});

  @override
  List<Object> get props => [capsuleId, isFavorite];
}

class CapsuleDelete extends CapsuleEvent {
  final String capsuleId;
  const CapsuleDelete({required this.capsuleId});

  @override
  List<Object> get props => [capsuleId];
}

class CapsuleView extends CapsuleEvent {
  final String capsuleId;
  const CapsuleView({required this.capsuleId});

  @override
  List<Object> get props => [capsuleId];
}
