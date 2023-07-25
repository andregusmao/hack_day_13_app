import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_app/bloc/person/events/person_add_event.dart';
import 'package:person_app/bloc/person/events/person_delete_event.dart';
import 'package:person_app/bloc/person/events/person_edit_event.dart';
import 'package:person_app/bloc/person/events/person_load_event.dart';
import 'package:person_app/bloc/person/events/person_save_event.dart';
import 'package:person_app/bloc/person/person_bloc.dart';
import 'package:person_app/bloc/person/states/person_adding_state.dart';
import 'package:person_app/bloc/person/states/person_editing_state.dart';
import 'package:person_app/bloc/person/states/person_error_state.dart';
import 'package:person_app/bloc/person/states/person_loaded_state.dart';
import 'package:person_app/bloc/person/states/person_waiting_state.dart';
import 'package:person_app/views/person_edit_view.dart';

class PersonView extends StatelessWidget {
  const PersonView({super.key});

  @override
  Widget build(BuildContext context) {
    PersonBloc bloc = BlocProvider.of<PersonBloc>(context);

    bloc.add(LoadEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pessoas'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => bloc.add(LoadEvent()),
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              iconSize: 24,
              splashRadius: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () => bloc.add(AddEvent()),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              iconSize: 24,
              splashRadius: 24,
            ),
          ),
        ],
      ),
      body: BlocListener<PersonBloc, PersonState>(
        listener: (context, state) {},
        child: BlocBuilder<PersonBloc, PersonState>(
          builder: (context, state) {
            if (state is ErrorState) {
              Future.delayed(Duration.zero, () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Atenção'),
                    content: const Text('Ocorreu um erro'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              });
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                state is WaitingState
                    ? const Expanded(
                        child: Stack(
                          children: [
                            LinearProgressIndicator(),
                            Center(
                              child: Text(
                                'Aguarde, carregando...',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : state is LoadedState
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: state.persons?.length ?? 0,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                      state.persons?[index].toString() ?? ''),
                                  // '${state.persons?[index].firstname ?? ''} ${state.persons?[index].surname ?? ''}'),
                                  subtitle:
                                      Text(state.persons?[index].email ?? ''),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Future.delayed(Duration.zero, () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Excluir Pessoa'),
                                            content: const Text(
                                                'Deseja realmente excluir?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  String id = state
                                                          .persons?[index].id ??
                                                      '';
                                                  if (id.isNotEmpty) {
                                                    bloc.add(DeleteEvent(id));
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Sim'),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Não'),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    },
                                    icon: const Icon(Icons.delete),
                                    iconSize: 24,
                                    splashRadius: 24,
                                  ),
                                  onTap: () => bloc.add(EditEvent(
                                      state.persons?[index].id ?? '')),
                                );
                              },
                              shrinkWrap: true,
                            ),
                          )
                        : state is AddingState
                            ? PersonEditView(
                                onSave: (person) => bloc.add(SaveEvent(person)),
                                onBack: () => bloc.add(LoadEvent()),
                              )
                            : state is EditingState
                                ? PersonEditView(
                                    person: state.person,
                                    onSave: (person) =>
                                        bloc.add(SaveEvent(person)),
                                    onBack: () => bloc.add(LoadEvent()),
                                  )
                                : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
