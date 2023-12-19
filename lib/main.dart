import 'package:anywhere_list_app/bloc/SimpsonsListBloc.dart';
import 'package:anywhere_list_app/pages/CharacterListPage.dart';
import 'package:anywhere_list_app/repository/CharacterRepository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


final serviceLocator = GetIt.instance;

void main() {
  serviceLocator.registerLazySingleton(
    () => SimpsonsBloc(simpsonsRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(() => SimpsonsRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SimpsonsListPage(),
    );
  }
}
