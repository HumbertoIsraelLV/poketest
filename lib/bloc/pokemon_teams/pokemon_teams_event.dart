part of 'pokemon_teams_bloc.dart';

@immutable
abstract class PokemonTeamsEvent {}

class ReadPokemonTeamsData extends PokemonTeamsEvent {
  ReadPokemonTeamsData();
}

class UpdatePokemonTeamsData extends PokemonTeamsEvent {
  final Map<String, List<int>> updatedTeamIds;
  UpdatePokemonTeamsData(this.updatedTeamIds);
}