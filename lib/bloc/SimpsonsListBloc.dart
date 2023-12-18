import 'package:anywhere_list_app/entities/CharacterEntity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/CharacterRepository.dart';



class SimpsonsBloc extends Bloc<SimpsonsEvent, SimpsonsListState> {

  SimpsonsBloc(
      super.initialState,
      {required SimpsonsRepository simpsonsRepository})
      : _repository = simpsonsRepository {
    on<GetSimpsonsCharactersListEvent>(
            (event, emit) => onGetSimpsonsListEvent(event, emit));
    on<SearchSimpsonsCharactersListEvent>(
            (event, emit) => onSearchSimpsonsListEvent(event, emit));
  }

  final SimpsonsRepository _repository;



  onGetSimpsonsListEvent(GetSimpsonsCharactersListEvent event, Emitter emit) async {
    List<Character> simpsonsCharacters = await _repository.getCharacterList();

    emit(
        SimpsonsListState.loadedDetails(simpsonsCharacters)
    );
  }

  onSearchSimpsonsListEvent(SearchSimpsonsCharactersListEvent event, Emitter emit) async {
    List<Character> searchResults = await _repository.searchCharacterList(event.searchText, event.searchableCharacters);

    for (var result in searchResults) {
      print(result.name.toString());
    }
    emit(
        SimpsonsListState.loadedDetails(searchResults)
    );
  }

}

class SimpsonsEvent {}


class GetSimpsonsCharactersListEvent extends SimpsonsEvent {

  GetSimpsonsCharactersListEvent();
}

class SearchSimpsonsCharactersListEvent extends SimpsonsEvent {
  final String searchText;
  final List<Character> searchableCharacters;

  SearchSimpsonsCharactersListEvent({required this.searchText, required this.searchableCharacters});
}

class SimpsonsListState {
  final List<Character> characters;

  SimpsonsListState.empty(this.characters);
  SimpsonsListState.loading(this.characters);
  SimpsonsListState.loadedCharacters(this.characters);
  SimpsonsListState.loadedDetails(this.characters);
}