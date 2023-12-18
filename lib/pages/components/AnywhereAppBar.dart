import 'package:anywhere_list_app/bloc/CharacterEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../bloc/CharacterBloc.dart';
import '../../bloc/CharacterState.dart';
import '../../entities/CharacterEntity.dart';
import '../../main.dart';
class SimpsonsAppBar extends HookWidget implements PreferredSizeWidget {
  SimpsonsAppBar({super.key, required this.searchable});
  final bool searchable;

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<SimpsonsBloc>(),
      child: SimpsonsAppBarContents(searchable: searchable,),
    );
  }
}

class SimpsonsAppBarContents extends HookWidget{
  SimpsonsAppBarContents({super.key, required this.searchable});

  final bool searchable;
  final TextEditingController searchController = useTextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimpsonsBloc, SimpsonsListState>(builder:  (context, state) {
      List<Character> characters = state.characters;


   if (searchable) {

     return   AppBar(
      backgroundColor: Colors.blue,
      title: TextField(
        controller: searchController,
        onChanged: (text) {
          context.read<SimpsonsBloc>().add(
          SearchSimpsonsCharactersListEvent(
            searchText: text,
            searchableCharacters: characters,
        ),
        );
        },
        // style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
      ),
    );
   }
   else {
     return AppBar(
       backgroundColor: Colors.blue,
       title: const Text('character name'),
       leading: const BackButton(),
     );
   }
    });
  }
}