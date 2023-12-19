import 'package:anywhere_list_app/bloc/SimpsonsListBloc.dart';
import 'package:anywhere_list_app/entities/CharacterEntity.dart';
import 'package:anywhere_list_app/main.dart';
import 'package:anywhere_list_app/pages/CharacterDetailsPage.dart';
import 'package:anywhere_list_app/pages/components/SimpsonListTile.dart';
import 'package:anywhere_list_app/pages/components/SimpsonsErrorWidget.dart';
import 'package:anywhere_list_app/pages/components/SimpsonsLoadingWidget.dart';
import 'package:anywhere_list_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SimpsonsListPage extends HookWidget {
  const SimpsonsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<SimpsonsBloc>()..add(GetSimpsonsCharactersListEvent()),
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
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[300],
          title: TextField(
            decoration: InputDecoration(hintText: searchHintText),
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: searchController,
            onChanged: (text) {
              serviceLocator<SimpsonsBloc>().add(
                SearchSimpsonsCharactersListEvent(
                  searchText: text,
                  searchableCharacters: characters,
                ),
              );
            },
          ),
        ),
        body: state.status == SimpsonsStateStatus.loaded
            ? ListView.builder(
                itemCount: state.characters.length,
                itemBuilder: (BuildContext context, int index) {
                  return SimpsonListTile(
                    character: characters[index],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CharacterDetailsPage(
                            character: characters[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : state.status == SimpsonsStateStatus.loading
                ? const SimpsonsLoadingWidget()
                : const SimpsonsErrorWidget(),
      );
    });
  }
}
