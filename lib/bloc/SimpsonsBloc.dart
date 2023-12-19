
import 'package:anywhere_list_app/entities/CharacterEntity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/SimpsonsRepository.dart';

enum SimpsonsStateStatus { error, loading, loaded }

class SimpsonsListState {
  final List<Simpson> characters;
  final SimpsonsStateStatus status;

  SimpsonsListState.error({
    this.characters = const [],
    this.status = SimpsonsStateStatus.error,
  });
  SimpsonsListState.loading({
    this.characters = const [],
    this.status = SimpsonsStateStatus.loading,
  });
  SimpsonsListState.loaded({
    required this.characters,
    this.status = SimpsonsStateStatus.loaded,
  });
}

class SimpsonsBloc extends Bloc<SimpsonsEvent, SimpsonsListState> {
  SimpsonsBloc({required SimpsonsRepository simpsonsRepository})
      : _repository = simpsonsRepository,
        super(SimpsonsListState.loading()) {
    on<GetSimpsons>(
        (event, emit) => onGetSimpsons(event, emit));
    on<SearchSimpsons>(
        (event, emit) => onSearchSimpsons(event, emit));
  }

  final SimpsonsRepository _repository;

  onGetSimpsons(
      GetSimpsons event, Emitter emit) async {
    emit(SimpsonsListState.loading());

    List<Simpson>? simpsonsCharacters = await _repository.getSimpsons();

    if (simpsonsCharacters == null) {
      emit(SimpsonsListState.error());

    } else {
      emit(SimpsonsListState.loaded(characters: simpsonsCharacters!));
    }

  }

  onSearchSimpsons(
      SearchSimpsons event, Emitter emit) async {
    emit(SimpsonsListState.loading());

    List<Simpson> searchResults = await _repository.searchSimpsons(
        event.searchText, event.searchableCharacters);

      emit(SimpsonsListState.loaded(characters: searchResults));

  }
}

class SimpsonsEvent {}
class GetSimpsons extends SimpsonsEvent {
  GetSimpsons();
}

class SearchSimpsons extends SimpsonsEvent {
  final String searchText;
  final List<Simpson> searchableCharacters;

  SearchSimpsons(
      {required this.searchText, required this.searchableCharacters});
}
