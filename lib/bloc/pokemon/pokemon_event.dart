part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class ReadPokemonData extends PokemonEvent {
  ReadPokemonData();
}