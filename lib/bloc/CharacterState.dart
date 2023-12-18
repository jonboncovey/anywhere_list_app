import '../entities/CharacterEntity.dart';

class SimpsonsListState {
final List<Character> characters;

SimpsonsListState.empty(this.characters);
SimpsonsListState.loading(this.characters);
SimpsonsListState.loadedCharacters(this.characters);
SimpsonsListState.loadedDetails(this.characters);
}