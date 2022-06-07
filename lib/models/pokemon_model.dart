import 'dart:convert';

PokemonModel pokemonModelFromJson(String str) => PokemonModel.fromJson(json.decode(str));

class PokemonModel {
    PokemonModel({
       required this.abilities,
       required this.baseExperience,
       required this.height,
       required this.id,
       required this.moves,
       required this.name,
       required this.species,
       required this.stats,
       required this.types,
       required this.weight,
    });

    List<Ability> abilities;
    int baseExperience;
    int height;
    int id;
    List<Move> moves;
    String name;
    Species species;
    List<Stat> stats;
    List<Type> types;
    int weight;

    factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
        baseExperience: json["base_experience"],
        height: json["height"],
        id: json["id"],
        moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
        name: json["name"],
        species: Species.fromJson(json["species"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        weight: json["weight"],
    );

}

class Ability {
    Ability({
        required this.ability,
        required this.isHidden,
        required this.slot,
    });

    Species ability;
    bool isHidden;
    int slot;

    factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        ability: Species.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
    );

    Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
    };
}

class Species {
    Species({
        required this.name,
    });

    String name;

    factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class GameIndex {
    GameIndex({
        required this.gameIndex,
        required this.version,
    });

    int gameIndex;
    Species version;

    factory GameIndex.fromJson(Map<String, dynamic> json) => GameIndex(
        gameIndex: json["game_index"],
        version: Species.fromJson(json["version"]),
    );

    Map<String, dynamic> toJson() => {
        "game_index": gameIndex,
        "version": version.toJson(),
    };
}

class Move {
    Move({
        required this.move,
        required this.versionGroupDetails,
    });

    Species move;
    List<VersionGroupDetail> versionGroupDetails;

    factory Move.fromJson(Map<String, dynamic> json) => Move(
        move: Species.fromJson(json["move"]),
        versionGroupDetails: List<VersionGroupDetail>.from(json["version_group_details"].map((x) => VersionGroupDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "move": move.toJson(),
        "version_group_details": List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
    };
}

class VersionGroupDetail {
    VersionGroupDetail({
        required this.levelLearnedAt,
        required this.moveLearnMethod,
        required this.versionGroup,
    });

    int levelLearnedAt;
    Species moveLearnMethod;
    Species versionGroup;

    factory VersionGroupDetail.fromJson(Map<String, dynamic> json) => VersionGroupDetail(
        levelLearnedAt: json["level_learned_at"],
        moveLearnMethod: Species.fromJson(json["move_learn_method"]),
        versionGroup: Species.fromJson(json["version_group"]),
    );

    Map<String, dynamic> toJson() => {
        "level_learned_at": levelLearnedAt,
        "move_learn_method": moveLearnMethod.toJson(),
        "version_group": versionGroup.toJson(),
    };
}

class Stat {
    Stat({
        required this.baseStat,
        required this.effort,
        required this.stat,
    });

    int baseStat;
    int effort;
    Species stat;

    factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Species.fromJson(json["stat"]),
    );

    Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
    };
}

class Type {
    Type({
        required this.slot,
        required this.type,
    });

    int slot;
    Species type;

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
    };
}