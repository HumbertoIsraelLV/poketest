import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class PokemonService {

  static Map<String, List<int>> teamsIds = {};

  static Map<String, List<PokemonModel>> teamsData = {};

  static Map<int, PokemonModel?> pokemonData = {};

  static late PokemonModel currentPokemon; 

  static Map<String, Color> colors = {
    'fire': Colors.red[300]!,
    'water': Colors.blue[300]!,
    'grass': Colors.green[300]!,
    'bug': Colors.green[300]!,
  };
  
  static Future<PokemonModel?> readPokemonById(int id) async {
    if(pokemonData.containsKey(id)) return pokemonData[id];
    try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id/'));
      if(response.statusCode==200){
        final auxPokemon = pokemonModelFromJson(response.body);
        pokemonData[id]=auxPokemon;
        return pokemonModelFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<List<PokemonModel>> readPokemon() async {
    try {
      List<PokemonModel> pokemonList = [];
      for (var i = 1; i <= 4; i++) {
        final auxPokemon = await readPokemonById(i);
        if(auxPokemon!=null) pokemonList.add(auxPokemon);
      }
      return pokemonList;
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  static Future<Map<String, List<PokemonModel>>> readPokemonTeamsIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final auxTeams = json.decode(prefs.getString('teams')?? '{}');
      for (var teamName in auxTeams.keys) {
        List<int> teamIds = [];
        for(var id in auxTeams[teamName]){
          teamIds.add(int.parse(id.toString()));
        }
        teamsIds[teamName]=teamIds;
      }
      return {};
    } catch (e) {
      log(e.toString());
    }
    return {};
  }
  
  static Future<Map<String, List<PokemonModel>>> readPokemonTeamsData() async {
    try {
      if(teamsIds.isEmpty) await readPokemonTeamsIds();
      for(String teamName in teamsIds.keys){
        List<PokemonModel> pokemonList = [];
        for(int id in teamsIds[teamName]!){
          final auxPokemon = await readPokemonById(id);
          if(auxPokemon!=null) pokemonList.add(auxPokemon);
        }
        teamsData[teamName]=pokemonList;
      } 
      return teamsData;
    } catch (e) {
      log(e.toString());
    }
    return {};
  }

  static Future<bool> deletePokemonTeam(String teamName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      teamsData.removeWhere((key, value) => key==teamName);
      teamsIds.removeWhere((key, value) => key==teamName);
      prefs.setString('teams', json.encode(teamsIds));
      return true;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

}