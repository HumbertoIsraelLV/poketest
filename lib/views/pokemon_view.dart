import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poketest/services/pokemon_service.dart';
import 'package:poketest/services/services.dart';

class PokemonView extends StatelessWidget {
   
  const PokemonView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokemonService.colors[PokemonService.currentPokemon.types[0].type.name]?? Colors.grey,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              right: -MediaQuery.of(context).size.width*0.1,
              top: MediaQuery.of(context).size.height*0.18,
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.25,
                width: MediaQuery.of(context).size.height*0.25,
                child: Opacity(
                  opacity: 0.2,
                  child: CachedNetworkImage(
                    imageUrl: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/f720bb6e-b303-4877-bffb-d61df0ab183f/d3b98cf-4fc5c76b-2a99-47fc-98b6-d7d4ee8d9d9f.png/v1/fill/w_256,h_256,q_75,strp/pokeball_desktop_icon_by_beccerberry-d3b98cf.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvaS9mNzIwYmI2ZS1iMzAzLTQ4NzctYmZmYi1kNjFkZjBhYjE4M2YvZDNiOThjZi00ZmM1Yzc2Yi0yYTk5LTQ3ZmMtOThiNi1kN2Q0ZWU4ZDlkOWYucG5nIiwid2lkdGgiOiI8PTI1NiIsImhlaWdodCI6Ijw9MjU2In1dXX0.E4UIkYYglmei_cE2crKjE0lIwf81zephW1R1k6Xwglo',
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.01,
              left: MediaQuery.of(context).size.width*0.02,
              child: BackButton(
                color: Colors.grey[200],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.07,
              left: MediaQuery.of(context).size.width*0.06,
              child: Text('${PokemonService.currentPokemon.name.substring(0,1).toUpperCase()}${PokemonService.currentPokemon.name.substring(1)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 33,
                  color: Colors.grey[200],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.14,
              left: MediaQuery.of(context).size.width*0.06,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: PokemonService.currentPokemon.types.map((type) => _PokemonPill(typeName: type.type.name)).toList(),
              )
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*0.1,
              right: MediaQuery.of(context).size.width*0.06,
              child: Text('#${'0' * (3-PokemonService.currentPokemon.id.toString().length)}${PokemonService.currentPokemon.id}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[200],
                ),
              ),
            ),
            const _PokemonInfo(),
            Positioned(
              top: MediaQuery.of(context).size.height*0.20,
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.25,
                width: MediaQuery.of(context).size.height*0.25,
                child: CachedNetworkImage(
                  imageUrl: 'https://cdn.traction.one/pokedex/pokemon/${PokemonService.currentPokemon.id}.png'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PokemonPill extends StatelessWidget {
  final String typeName; 
  const _PokemonPill({
    Key? key, 
    required this.typeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(typeName,
                style: const TextStyle(
                  color: Colors.transparent,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),
          ),
          Text(typeName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _PokemonInfo extends StatelessWidget {
  const _PokemonInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: MediaQuery.of(context).size.height*0.55,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height*0.05,
          left: MediaQuery.of(context).size.width*0.06,
          right: MediaQuery.of(context).size.width*0.06,
          bottom: MediaQuery.of(context).size.height*0.025,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.grey[700],
                tabs: const [
                  Tab(
                    child: Text('About',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text('Base Stats',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text('Moves',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    _PokemonAbout(),
                    _PokemonBaseStats(),
                    _PokemonMoves(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PokemonAbout extends StatelessWidget {
  const _PokemonAbout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height*0.02,
      ),
      child: Column(
        children: [
          _PokemonInfoRow(
            attribute: 'Species',
            value: PokemonService.currentPokemon.species.name,
          ),
          _PokemonInfoRow(
            attribute: 'Height',
            value: '${PokemonService.currentPokemon.height/10} m',
          ),
          _PokemonInfoRow(
            attribute: 'Weight',
            value: '${PokemonService.currentPokemon.weight/10} kg',
          ),
          _PokemonInfoRow(
            attribute: 'Abilities',
            value: '${PokemonService.currentPokemon.abilities.map((ability) => ability.ability.name)}',
          ),
          _PokemonInfoRow(
            attribute: 'Base Experience',
            value: '${PokemonService.currentPokemon.baseExperience}',
          ),
        ],
      ),
    );
  }
}

class _PokemonBaseStats extends StatelessWidget {
  const _PokemonBaseStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height*0.02,
      ),
      child: Column(
        children: [
          ...PokemonService.currentPokemon.stats.map(
            (stat) => _PokemonInfoRow(
              attribute: '${stat.stat.name.substring(0,1).toUpperCase()}${stat.stat.name.substring(1)}',
              value: '${stat.baseStat} pts.',
            ),
          ).toList(),
        ],
      ),
    );
  }
}

class _PokemonMoves extends StatelessWidget {
  const _PokemonMoves({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height*0.02,
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ...PokemonService.currentPokemon.moves.map(
            (move) => _PokemonInfoRow(
              attribute: '#${PokemonService.currentPokemon.moves.indexOf(move)+1}',
              value: move.move.name,
            ),
          ).toList(),
        ],
      ),
    );
  }
}

class _PokemonInfoRow extends StatelessWidget {
  final String attribute;
  final String value;
  final Widget? valueWidget;
  const _PokemonInfoRow({
    Key? key, 
    required this.attribute, 
    required this.value,
    this.valueWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height*0.02,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(attribute, 
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                (valueWidget!=null) ?valueWidget! :const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PokemonInfoTitle extends StatelessWidget {
  final String title;
  const _PokemonInfoTitle({
    Key? key, 
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height*0.03,
        top: MediaQuery.of(context).size.height*0.02,
      ),
      child: Row(
        children: [
          Text(title, 
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}