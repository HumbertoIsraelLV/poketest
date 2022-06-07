part of 'pokemon_teams_bloc.dart';

@immutable
abstract class PokemonTeamsState {
  final Map<String, List<int>>? teamsIds;

  const PokemonTeamsState({
    this.teamsIds
  });
}

class PokemonTeamsInitial extends PokemonTeamsState {
  const PokemonTeamsInitial() : super();
}

class PokemonTeamsUpdated extends PokemonTeamsState {
  final Map<String, List<int>>? updatedTeamsIds;
  const PokemonTeamsUpdated(this.updatedTeamsIds) 
    : super( teamsIds: updatedTeamsIds);
}