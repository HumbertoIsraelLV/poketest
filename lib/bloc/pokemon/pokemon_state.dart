part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {
  final Map<String, List<int>> teamsIds;

  const PokemonState({
    required this.teamsIds 
  });
}

class PokemonInitial extends PokemonState {
  PokemonInitial(): super(teamsIds: {});
}

class PokemonUpdated extends PokemonState {
  final Map<String, List<int>> updatedTeamsIds;
  const PokemonUpdated( this.updatedTeamsIds) : super(teamsIds: updatedTeamsIds);
}