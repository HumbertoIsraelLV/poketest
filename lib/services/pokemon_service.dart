import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class PokemonService {

  static late PokemonModel currentPokemon; 

  static Map<String, Color> colors = {
    'fire': Colors.red[300]!,
    'water': Colors.blue[300]!,
    'grass': Colors.green[300]!,
    'bug': Colors.green[300]!,
    'poison': Colors.purple[300]!,
    'ghost': Colors.purple[300]!,
    'psychic': Colors.yellow[700]!,
    'electric': Colors.yellow[700]!,
    'ground': Colors.brown[300]!,
    'fighting': Colors.brown[300]!,
    'fairy': Colors.pink[300]!,
  };

  static Future<PokemonModel?> readPokemonById(int id) async {
    try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id/'));
      if(response.statusCode==200){
        return pokemonModelFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<List<PokemonModel>> readPokemonData() async {
    try {
      List<PokemonModel> pokemonList = [];
      for (var i = 1; i <= 30; i++) {
        final auxPokemon = await readPokemonById(i);
        if(auxPokemon!=null) pokemonList.add(auxPokemon);
      }
      return pokemonList;
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  static Future<Map<String, List<int>>> readPokemonTeamsIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final auxTeams = json.decode(prefs.getString('teams')?? '{}');
      final Map<String, List<int>> auxTeamsIds = {}; 
      for (var teamName in auxTeams.keys) {
        List<int> teamIds = [];
        for(var id in auxTeams[teamName]){
          teamIds.add(int.parse(id.toString()));
        }
        auxTeamsIds[teamName]=teamIds;
      }
      return auxTeamsIds;
    } catch (e) {
      log(e.toString());
    }
    return {};
  }

}