import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blocs.dart';
import '../services/services.dart';

class TeamsView extends StatelessWidget {
   
  const TeamsView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Teams'),
        actions: const [
          Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            message: 'Dismiss a team to delete it.',
            child: IconButton(
              disabledColor: Colors.white,
              onPressed: null,
              icon: Icon(Icons.info_outline_rounded)
            ),
          ),
        ],
      ),
      body: Stack(
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
          BlocBuilder<PokemonTeamsBloc, PokemonTeamsState>(
            builder: (context, state){
              if(state.teamsIds!.isEmpty){
                return const Center(
                  child: Text('No teams stored',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.teamsIds!.entries.length,
                itemBuilder: ((context, index) {
                  return _TeamsListTile(
                    index: index,
                    teamName: state.teamsIds!.keys.elementAt(index),
                    teamIds: state.teamsIds!.values.elementAt(index),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TeamsListTile extends StatelessWidget {
  final int index;
  final List<int> teamIds;
  final String teamName;
  const _TeamsListTile({
    Key? key, 
    required this.index, 
    required this.teamIds,
    required this.teamName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width*0.06,
              ),
              child: const Text('Delete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      key: Key(teamName),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) async {
        final pokemonTeamsBloc = BlocProvider.of<PokemonTeamsBloc>(context, listen: false);
        Map<String, List<int>> auxTeamsIds = {}..addAll(pokemonTeamsBloc.state.teamsIds!);
        auxTeamsIds.remove(teamName);
        pokemonTeamsBloc.add(UpdatePokemonTeamsData(auxTeamsIds));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            iconColor: Colors.grey,
          ),
          header: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 12,
            ),
            child: Text('#${index+1} - $teamName',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          collapsed: const SizedBox(),
          expanded: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: teamIds.length,
              itemBuilder: (context, teamDataIndex){
                final pokemonBloc = BlocProvider.of<PokemonBloc>(context, listen: false);
                return ListTile(
                  title: Text('#${index+1} / #${teamDataIndex+1} - ${pokemonBloc.state.pokemonData![teamDataIndex].name}',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    softWrap: true, 
                  ),
                  onTap: (){
                    PokemonService.currentPokemon=pokemonBloc.state.pokemonData![teamDataIndex];
                    Navigator.pushNamed(context, 'pokemon');
                  },
                  trailing: SizedBox(
                    height: 30,
                    width: 30,
                    child: CachedNetworkImage(
                      imageUrl: 'https://cdn.traction.one/pokedex/pokemon/${pokemonBloc.state.pokemonData![teamDataIndex].id}.png',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}