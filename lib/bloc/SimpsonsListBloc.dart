
import 'package:anywhere_list_app/entities/CharacterEntity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/CharacterRepository.dart';

enum SimpsonsStateStatus { error, loading, loaded }

class SimpsonsListState {
  final List<Character> characters;
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
    on<GetSimpsonsCharactersListEvent>(
        (event, emit) => onGetSimpsonsListEvent(event, emit));
    on<SearchSimpsonsCharactersListEvent>(
        (event, emit) => onSearchSimpsonsListEvent(event, emit));
  }

  final SimpsonsRepository _repository;

  onGetSimpsonsListEvent(
      GetSimpsonsCharactersListEvent event, Emitter emit) async {
    emit(SimpsonsListState.loading());

    List<Character>? simpsonsCharacters = await _repository.getCharacterList();

    if (simpsonsCharacters == null) {
      emit(SimpsonsListState.error());

    } else {
      emit(SimpsonsListState.loaded(characters: simpsonsCharacters!));
    }

  }

  onSearchSimpsonsListEvent(
      SearchSimpsonsCharactersListEvent event, Emitter emit) async {
    emit(SimpsonsListState.loading());

    List<Character> searchResults = await _repository.searchCharacterList(
        event.searchText, event.searchableCharacters);

      emit(SimpsonsListState.loaded(characters: searchResults));

  }
}

class SimpsonsEvent {}

class GetSimpsonsCharactersListEvent extends SimpsonsEvent {
  GetSimpsonsCharactersListEvent();
}

class SearchSimpsonsCharactersListEvent extends SimpsonsEvent {
  final String searchText;
  final List<Character> searchableCharacters;

  SearchSimpsonsCharactersListEvent(
      {required this.searchText, required this.searchableCharacters});
}
