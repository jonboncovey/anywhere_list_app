import 'package:anywhere_list_app/bloc/SimpsonsListBloc.dart';
import 'package:anywhere_list_app/pages/CharacterListPage.dart';
import 'package:anywhere_list_app/repository/CharacterRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'entities/CharacterEntity.dart';

final serviceLocator = GetIt.instance;

void main() {
  serviceLocator.registerLazySingleton(() => SimpsonsBloc(
      SimpsonsListState.empty(
        [],
  ), simpsonsRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => SimpsonsRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SimpsonsListPage(),
      );
  }
}

