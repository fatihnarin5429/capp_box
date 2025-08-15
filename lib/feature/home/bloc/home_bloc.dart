import 'package:bloc/bloc.dart';
import 'package:capp_box/feature/create_capsul/model/get_capsule_response_model.dart';
import 'package:capp_box/feature/home/service/home_datasources.dart';
import 'package:capp_box/feature/home/service/home_usecases.dart';
import 'package:capp_box/feature/login/services/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    // on<CapsuleSearch>(_onCapsuleSearch);
    on<CapsuleFilter>(_onCapsuleFilter);
    on<CapsuleSort>(_onCapsuleSort);

    // on<CapsuleFavorite>(_onCapsuleFavorite);
    // on<CapsuleDelete>(_onCapsuleDelete);
    on<CapsuleView>(_onCapsuleView);
    on<HomeGetCapsules>(_onHomeGetCapsules);
    on<HomeGetUser>(_onHomeGetUser);
    on<HomeSetUser>(_onHomeSetUser);
  }

  final HomeUsecase homeUsecase = HomeUsecase(HomeRemoteDatasource());

  Future<void> _onHomeGetCapsules(
    HomeGetCapsules event,
    Emitter<HomeState> emit,
  ) async {
    try {
      GetCapsulesResponseModel capsules = await homeUsecase.fetchCapsules();
      emit(state.copyWith(capsules: capsules.data));
    } catch (e) {
      print('Kapsüller getirilirken hata: $e');
      // Kullanıcı giriş yapmamışsa sessizce geç, hata gösterme
      if (e.toString().contains('Lütfen giriş yapın')) {
        emit(state.copyWith(capsules: []));
      } else {
        // Diğer hatalar için state'i güncelle
        emit(state.copyWith(capsules: []));
      }
    }
  }

  // Future<void> _onCapsuleSearch(
  //   CapsuleSearch event,
  //   Emitter<HomeState> emit,
  // ) async {
  //   final searchQuery = event.searchQuery.toLowerCase();
  //   final filteredCapsules =
  //       state.capsules.where((capsule) {
  //         return capsule.title.toLowerCase().contains(searchQuery) ||
  //             capsule.content.toLowerCase().contains(searchQuery);
  //       }).toList();

  //   emit(
  //     state.copyWith(
  //       searchQuery: event.searchQuery,
  //       filteredCapsules: filteredCapsules,
  //     ),
  //   );
  // }

  Future<void> _onCapsuleFilter(
    CapsuleFilter event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(filterType: event.filterType));
    // Implement filtering logic based on filterType
  }

  Future<void> _onCapsuleSort(
    CapsuleSort event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(sortBy: event.sortBy));
    // Implement sorting logic based on sortBy
  }

  // Future<void> _onCapsuleFavorite(
  //   CapsuleFavorite event,
  //   Emitter<HomeState> emit,
  // ) async {
  //   // Update favorite status logic here
  //   // Update the capsule in the database
  // }

  // Future<void> _onCapsuleDelete(
  //   CapsuleDelete event,
  //   Emitter<HomeState> emit,
  // ) async {
  //   try {
  //     // Remove the deleted capsule from the state
  //     final updatedCapsules =
  //         state.capsules
  //             .where((capsule) => capsule.id != event.capsuleId)
  //             .toList();

  //     emit(state.copyWith(capsules: updatedCapsules));
  //   } catch (e) {
  //     emit(state.copyWith(status: CapsuleStatus.error, error: e.toString()));
  //   }
  // }

  Future<void> _onCapsuleView(
    CapsuleView event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(selectedCapsuleId: event.capsuleId));
  }

  Future<void> _onHomeGetUser(
    HomeGetUser event,
    Emitter<HomeState> emit,
  ) async {
    // Burada user'ı bir servisten, localden veya mock olarak alabilirsin.
    // Örnek:
    // final user = UserModel(
    //   name: "Fatih Narin",
    //   photo: "https://picsum.photos/200/300",
    // );
    // emit(state.copyWith(userModel: user));
  }

  Future<void> _onHomeSetUser(
    HomeSetUser event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(userModel: event.user));
  }
}
