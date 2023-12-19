import 'dart:convert';
import 'dart:ffi';

import 'package:anywhere_list_app/entities/CharacterEntity.dart';
import 'package:http/http.dart' as http;

class SimpsonsRepository {

  List<Character> characterList = [];


  Future<List<Character>?> getCharacterList() async {

    try {
      http.Response response = await http.get(Uri.parse('https://api.duckduckgo.com/?q=simpsons+characters&format=json'));
      var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      jsonResponse["RelatedTopics"].forEach((rawCharacter) {
        String characterName =  rawCharacter["Text"].split(" - ")[0];
        String characterDescription =  rawCharacter["Text"].split(" - ")[1];
        String characterImageUri = rawCharacter["Icon"]["URL"];

        characterImageUri.isNotEmpty
            ? characterImageUri = "https://duckduckgo.com$characterImageUri"
            : characterImageUri = "https://www.boredpanda.com/blog/wp-content/uploads/2022/04/sims-6256d7a3872a8__700.jpg";

        characterList.add(
            Character(
              name: characterName,
              description: characterDescription,
              imageFilepath: characterImageUri,
            )
        );
      });
    }
    catch (e) {
      return null;
    }



    return characterList;
  }


  Future<List<Character>> searchCharacterList(String searchText, List<Character> characters) async {
    List<Character> searchResults = [];
    if (searchText.isEmpty){
      return characterList;
    }
    for (var char in characterList) {
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
      return [];
    }

  }


}