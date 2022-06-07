import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/services.dart';

part 'pokemon_teams_event.dart';
part 'pokemon_teams_state.dart';

class PokemonTeamsBloc extends Bloc<PokemonTeamsEvent, PokemonTeamsState> {
  PokemonTeamsBloc() : super(const PokemonTeamsInitial()) {
    
    on<ReadPokemonTeamsData>((event, emit) async {
      final pokemonTeamsIds = await PokemonService.readPokemonTeamsIds();
      emit(PokemonTeamsUpdated(pokemonTeamsIds));
    });
    
    on<UpdatePokemonTeamsData>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('teams', json.encode(event.updatedTeamIds));
      emit(PokemonTeamsUpdated(event.updatedTeamIds));
    });
  }
}
