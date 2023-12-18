import 'package:flutter/material.dart';

import '../entities/CharacterEntity.dart';

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
        backgroundColor: Colors.blue,
        title: const Text('character name'),
        leading: BackButton(
        ),
      ),
      body: Center(child: Column(children: [
        Text(character.name),
        Expanded(child: Image.network(character.imageFilepath)),
        Text(character.description)
      ])),
    );
  }


}