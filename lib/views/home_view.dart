import 'package:cached_network_image/cached_network_image.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../bloc/blocs.dart';
import '../components/components.dart';
import '../models/models.dart';
import '../services/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final controller = DragSelectGridViewController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scheduleRebuild);
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  void scheduleRebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: -MediaQuery.of(context).size.width*0.18,
              top: -MediaQuery.of(context).size.height*0.02,
              child: Opacity(
                opacity: 0.2,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.3,
                  width: MediaQuery.of(context).size.height*0.3,
                  child: CachedNetworkImage(
                    imageUrl: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/f720bb6e-b303-4877-bffb-d61df0ab183f/d3b98cf-4fc5c76b-2a99-47fc-98b6-d7d4ee8d9d9f.png/v1/fill/w_256,h_256,q_75,strp/pokeball_desktop_icon_by_beccerberry-d3b98cf.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvaS9mNzIwYmI2ZS1iMzAzLTQ4NzctYmZmYi1kNjFkZjBhYjE4M2YvZDNiOThjZi00ZmM1Yzc2Yi0yYTk5LTQ3ZmMtOThiNi1kN2Q0ZWU4ZDlkOWYucG5nIiwid2lkdGgiOiI8PTI1NiIsImhlaWdodCI6Ijw9MjU2In1dXX0.E4UIkYYglmei_cE2crKjE0lIwf81zephW1R1k6Xwglo',
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width*0.045,
              top: MediaQuery.of(context).size.height*0.035,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: (){
                  showUpdateNameAlert(context);
                },
                child: FutureBuilder(
                  future: UserService.readUserName(),
                  builder: (context, AsyncSnapshot<String?> snapshot){
                    if(!snapshot.hasData) return const SizedBox();
                    if(snapshot.data!=''){
                    BlocProvider.of<UserBloc>(context, listen: false)
                      .add(UpdateUser(snapshot.data!));
                    }
                    return BlocBuilder<UserBloc, UserState>(
                      builder: (_, state) {
                        if(snapshot.data==''){
                          if(!state.wasRequested){
                            BlocProvider.of<UserBloc>(context, listen: false)
                              .add(RequestUser());
                            Future.microtask(() => showUpdateNameAlert(context));
                          }
                        }
                        return Text((state.name!=null)?'Welcome ${state.name}': '',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) => 
              Positioned(
                right: MediaQuery.of(context).size.width*0.06,
                top: MediaQuery.of(context).size.height*0.1,
                child: IconButton(
                  color: Colors.black,
                  onPressed: (state.pokemonData==null)
                  ?null 
                  :() => Navigator.pushNamed(context, 'teams'),
                  icon: const Icon(Icons.groups),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width*0.06,
              top: MediaQuery.of(context).size.height*0.1,
              child: const Text('Poketest',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.75,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<PokemonBloc, PokemonState>(
                  builder: (context, state){
                    if(state.pokemonData==null){
                      return Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height*0.06,
                          width: MediaQuery.of(context).size.height*0.06,
                          child: const CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.pokemonData!.length,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        maxCrossAxisExtent: 200,
                      ),
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*0.06,
                        right: MediaQuery.of(context).size.width*0.06,
                        bottom: MediaQuery.of(context).size.width*0.06,
                      ),
                      itemBuilder: (context, index){
                        return _PokemonCard(
                          pokemon: state.pokemonData![index],
                          index: index+1,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) => 
        FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: (state.pokemonData==null)
          ?null
          :()=>Navigator.pushNamed(context, 'create_team'),
          child: const Icon(Icons.group_add),
        ),
      ),
    );
  }
}

class _PokemonCard extends StatefulWidget {
  final PokemonModel pokemon;
  final int index;
  final bool selected;
  const _PokemonCard({
    Key? key, 
    required this.pokemon, 
    required this.index, 
    this.selected = false,
  }) : super(key: key);

  @override
  State<_PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<_PokemonCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      value: widget.selected ? 1 : 0,
      duration: kThemeChangeDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void didUpdateWidget(_PokemonCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      if (widget.selected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
            ),
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          color: PokemonService.colors[widget.pokemon.types[0].type.name]?? Colors.grey,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: (){
              PokemonService.currentPokemon=widget.pokemon;
              Navigator.pushNamed(context, 'pokemon');
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Text('${widget.pokemon.name.substring(0,1).toUpperCase()}${widget.pokemon.name.substring(1)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ...widget.pokemon.types.map((type) => _PokemonCardPill( typeName: type.type.name,))
                      .toList(),
                    ],
                  ),
                ),
                const Positioned(
                  right: -3,
                  bottom: -3,
                  child: _PokemonCardImageBackground(),
                ),
                Positioned(
                  right: 8,
                  bottom: 6,
                  child: _PokemonCardImage(
                    index: widget.index,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PokemonCardPill extends StatelessWidget {
  final String typeName; 
  const _PokemonCardPill({
    Key? key, 
    required this.typeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 20,
              child: Text(typeName,
                style: const TextStyle(
                  color: Colors.transparent,
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ),
          ),
          Text(typeName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _PokemonCardImageBackground extends StatelessWidget {
  const _PokemonCardImageBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: SizedBox(
        height: 75,
        width: 75,
        child: CachedNetworkImage(
          imageUrl: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/f720bb6e-b303-4877-bffb-d61df0ab183f/d3b98cf-4fc5c76b-2a99-47fc-98b6-d7d4ee8d9d9f.png/v1/fill/w_256,h_256,q_75,strp/pokeball_desktop_icon_by_beccerberry-d3b98cf.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvaS9mNzIwYmI2ZS1iMzAzLTQ4NzctYmZmYi1kNjFkZjBhYjE4M2YvZDNiOThjZi00ZmM1Yzc2Yi0yYTk5LTQ3ZmMtOThiNi1kN2Q0ZWU4ZDlkOWYucG5nIiwid2lkdGgiOiI8PTI1NiIsImhlaWdodCI6Ijw9MjU2In1dXX0.E4UIkYYglmei_cE2crKjE0lIwf81zephW1R1k6Xwglo',
        ),
      ),
    );
  }
}
class _PokemonCardImage extends StatelessWidget {
  final int index;
  const _PokemonCardImage({
    Key? key, 
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: CachedNetworkImage(
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$index.png'
      ),
    );
  }
}