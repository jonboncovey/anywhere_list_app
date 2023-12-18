import 'package:anywhere_list_app/entities/CharacterEntity.dart';
import 'package:flutter/material.dart';


class CharacterDetailsPage extends StatelessWidget{
  const CharacterDetailsPage({
    super.key,
    required this.character
  });

  final Character character;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text(character.name, style: const TextStyle(fontFamily: "Simpsonsfont",
            color: Colors.yellow
        )),
        leading: const BackButton(color: Colors.yellow),
      ),
      body: Center(child: Column(children: [
        Expanded(flex: 1, child: Image.network(character.imageFilepath)),
        Expanded(flex: 2, child: Text(character.description))
      ])),
    );
  }


}