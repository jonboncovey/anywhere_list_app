import 'package:anywhere_list_app/entities/CharacterEntity.dart';
import 'package:flutter/material.dart';

class SimpsonListTile extends StatelessWidget {
  const SimpsonListTile({
    super.key,
    required this.character,
    required this.onPressed,
  });

  final Simpson character;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
          title: Text(character.name, style: const TextStyle(fontSize: 18)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onTap: onPressed),
    );
  }
}
