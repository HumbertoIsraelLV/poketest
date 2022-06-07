part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class ReadPokemonTeamsIds extends PokemonEvent {
  final Map<String, List<int>> teamsIds;
  ReadPokemonTeamsIds(this.teamsIds);
}