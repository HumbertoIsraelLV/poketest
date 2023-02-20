import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poketest/views/views.dart';
import 'package:poketest/bloc/blocs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
        BlocProvider<PokemonBloc>(
          create: (BuildContext context) => PokemonBloc()..add(ReadPokemonData()),
        ),
        BlocProvider<PokemonTeamsBloc>(
          lazy: false,
          create: (BuildContext context) => PokemonTeamsBloc()..add(ReadPokemonTeamsData()),
        ),
      ],
      child: MaterialApp(
        title: 'Poketest',
        debugShowCheckedModeBanner: false,
        routes: {
          'home'        :(context) => const HomeView(),
          'teams'       :(context) => const TeamsView(),
          'pokemon'     :(context) => const PokemonView(),
          'create_team' :(context) => const CreateTeamView(),
        },
        initialRoute: 'home',
      ),
    );
  }
}