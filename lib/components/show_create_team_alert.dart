import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:poketest/bloc/blocs.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

showCreateTeamAlert(BuildContext context, DragSelectGridViewController gridController) async {
  final formKey = GlobalKey<FormBuilderState>();
  showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (_) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0))
      ),
      title: const Text("Create a team"),
      clipBehavior: Clip.hardEdge,
      titlePadding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
      contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CreateTeamForm(
            formKey: formKey
          ),
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    elevation: 5,
                    textColor: Colors.black,
                    onPressed: ()=>Navigator.pop(context),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: const Text('Cancel'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.04,
                  child: const VerticalDivider(
                    width: 1,
                    thickness: 1,
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    elevation: 5,
                    textColor: Colors.black,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () async {
                      formKey.currentState!.save();
                      if (formKey.currentState!.validate()) {
                        final pokemonTeamsBloc = BlocProvider.of<PokemonTeamsBloc>(context, listen: false);
                        pokemonTeamsBloc.add(UpdatePokemonTeamsData({}
                          ..addAll(pokemonTeamsBloc.state.teamsIds!)
                          ..addAll({formKey.currentState!.value['name']: gridController.value.selectedIndexes.map((item) => item+1).toList()})
                        ));
                        Future.microtask(() => Navigator.of(context).popUntil(ModalRoute.withName('create_team')));
                        Future.microtask(() async {
                          await Future.delayed(const Duration(
                            milliseconds: 500)
                          );
                          Future.microtask((() => 
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Team created!'),
                                duration: Duration(
                                  milliseconds: 800, 
                                ),
                              )
                            )
                          ));
                        });
                      }
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _CreateTeamForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const _CreateTeamForm({
    Key? key, 
    required this.formKey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'name',
              decoration: const InputDecoration(
                labelText: 'Name',
                border: InputBorder.none,
              ),
              onChanged: (val){},
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: 'Required field',
                ),
                FormBuilderValidators.minLength(
                  3,
                  errorText: 'Minimum lenght of 3 characters' 
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}