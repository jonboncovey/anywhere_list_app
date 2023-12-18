import 'package:anywhere_list_app/bloc/CharacterState.dart';
import 'package:anywhere_list_app/entities/CharacterEntity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/CharacterRepository.dart';
import 'CharacterEvent.dart';


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
