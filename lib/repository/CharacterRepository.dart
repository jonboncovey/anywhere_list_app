import 'dart:convert';
import 'dart:ffi';

import 'package:anywhere_list_app/entities/CharacterEntity.dart';
import 'package:http/http.dart' as http;

class SimpsonsRepository {

  List<Character> characterList = [];


  Future<List<Character>> getCharacterList() async {
    http.Response response = await http.get(Uri.parse('https://api.duckduckgo.com/?q=simpsons+characters&format=json'));

    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    jsonResponse["RelatedTopics"].forEach((rawCharacter) {
      String rawCharacterText = rawCharacter["Text"];
      List<String> splitText = rawCharacterText.split(" - ");
      String characterName = splitText[0];
      String characterDescription = splitText[1];
      String characterImageUri = rawCharacter["Icon"]["URL"];

      if (characterImageUri.isNotEmpty) {
        characterImageUri = "https://duckduckgo.com$characterImageUri";
      }

      characterList.add(
          Character(
              name: characterName,
              description: characterDescription,
              imageFilepath: characterImageUri));
    });

    return characterList;
  }


  Future<List<Character>> searchCharacterList(String searchText, List<Character> characters) async {
    List<Character> searchResults = [];
    print("SearchText:  $searchText");
    if (searchText.isEmpty){
      return characterList;
    }
    for (var char in characterList) {
      // I would typically refactor this to make lines ~50-60 more condensed,
      // but I wanted to be able to display "name" results ahead of
      // "description results and this was a straightforward and readable way
      // to accomplish that
      if (char.name.toLowerCase().contains(searchText) ||
          char.name.toUpperCase().contains(searchText))
      {
        searchResults.add(char);
      }

      if ((char.description.toLowerCase().contains(searchText) ||
          char.description.toUpperCase().contains(searchText)) &&
          searchResults.contains(char) == false)
      {
        searchResults.add(char);
      }

    }
    if (searchResults.isNotEmpty) {
      return searchResults;
    }
    else {
      return characterList;}

  }


}