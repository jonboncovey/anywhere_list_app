import '../entities/CharacterEntity.dart';

class SimpsonsEvent {}


class GetSimpsonsCharactersListEvent extends SimpsonsEvent {

  GetSimpsonsCharactersListEvent();
}

class SearchSimpsonsCharactersListEvent extends SimpsonsEvent {
  final String searchText;
  final List<Character> searchableCharacters;

  SearchSimpsonsCharactersListEvent({required this.searchText, required this.searchableCharacters});
}