import 'package:anywhere_list_app/pages/components/AnywhereAppBar.dart';
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
      appBar: SimpsonsAppBar(searchable: false,),
      body: Center(child: Column(children: [
        Text(character.name),
        Image.network(character.imageFilepath),
        Text(character.description)
      ])),
    );
  }


}