import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/services.dart';
import '../../models/models.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(const PokemonInitial()) {
    on<ReadPokemonData>((event, emit) async {
      final pokemonData = await PokemonService.readPokemonData(); 
      emit(PokemonUpdated(pokemonData));
    });
  }
}
