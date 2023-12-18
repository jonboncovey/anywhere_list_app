import 'package:anywhere_list_app/bloc/SimpsonsListBloc.dart';
import 'package:anywhere_list_app/main.dart';
import 'package:anywhere_list_app/pages/CharacterDetailsPage.dart';
import 'package:anywhere_list_app/pages/components/SimpsonListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../entities/CharacterEntity.dart';

class SimpsonsListPage extends HookWidget {
  const SimpsonsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<SimpsonsBloc>()..add(GetSimpsonsCharactersListEvent()),
      child: SimpsonsListPageContents(),
    );
  }
}

class SimpsonsListPageContents extends HookWidget {
  SimpsonsListPageContents({super.key});

  final TextEditingController searchController = useTextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SimpsonsBloc, SimpsonsListState>(
      builder: (context, state) {

      List<Character> characters = state.characters;
        return Scaffold(
          backgroundColor: Colors.yellow[100],
          appBar: AppBar(
            backgroundColor:Colors.lightBlue[300],
            title: TextField(
              controller: searchController,
              
              onChanged: (text) {
                BlocProvider.of<SimpsonsBloc>(context).add(
                  SearchSimpsonsCharactersListEvent(
                    searchText: text,
                    searchableCharacters: characters,
                  ),
                );
              },
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,

            ),
          ),
          body: ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (BuildContext context, int index) {
                return SimpsonListTile(
                    character: characters[index],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CharacterDetailsPage(character: characters[index],
                              ),
                          ),
                      );
                    },
                  );
              },
              )
        );
      }
    );

  }
}