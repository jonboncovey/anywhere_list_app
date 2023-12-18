import 'package:anywhere_list_app/bloc/CharacterBloc.dart';
import 'package:anywhere_list_app/bloc/CharacterEvent.dart';
import 'package:anywhere_list_app/main.dart';
import 'package:anywhere_list_app/pages/CharacterDetailsPage.dart';
import 'package:anywhere_list_app/pages/components/AnywhereAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/CharacterState.dart';
import '../entities/CharacterEntity.dart';

class SimpsonsListPage extends StatelessWidget {
  const SimpsonsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<SimpsonsBloc>()..add(GetSimpsonsCharactersListEvent()),
      child: const SimpsonsListPageContents(),
    );
  }
}

class SimpsonsListPageContents extends StatelessWidget {
  const SimpsonsListPageContents({super.key});


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SimpsonsBloc, SimpsonsListState>(
      builder: (context, state) {
        // context.read<SimpsonsBloc>().add(GetSimpsonsCharactersListEvent());

      List<Character> characters = state.characters;
        return Scaffold(
          appBar: SimpsonsAppBar(searchable: true,),
          body: ListView.builder(
              itemCount: state.characters.length,
              itemBuilder: (BuildContext context, int index) {
                // Typically I would break something like this out into it's own component, but that felt extra in this case
                return ListTile(
                  title: Text(characters[index].name,),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CharacterDetailsPage(character: characters[index],
                            ),
                        ),
                    );
                  },
                );
              }
              )
        );
      }
    );

  }
}