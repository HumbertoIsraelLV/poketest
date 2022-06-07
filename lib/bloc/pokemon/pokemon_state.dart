part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {
  final List<PokemonModel>? pokemonData;

  const PokemonState({
    this.pokemonData, 
  });
}

class PokemonInitial extends PokemonState {
  const PokemonInitial(): super();
}

class PokemonUpdated extends PokemonState {
  final List<PokemonModel> updatedPokemonData;
  const PokemonUpdated( this.updatedPokemonData) 
    : super(pokemonData: updatedPokemonData);
}