import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_app/bloc/person_bloc.dart';

class PersonView extends StatelessWidget {
  const PersonView({super.key});

  @override
  Widget build(BuildContext context) {
    PersonBloc _bloc = BlocProvider.of<PersonBloc>(context);

    _bloc.add(LoadEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pessoas'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => _bloc.add(LoadEvent()),
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
              onPressed: () => _bloc.add(AddEvent()),
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
                    ? Expanded(
                        child: Stack(
                          children: const [
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
                                      '${state.persons?[index].firstname ?? ''} ${state.persons?[index].surname ?? ''}'),
                                  subtitle:
                                      Text(state.persons?[index].email ?? ''),
                                  trailing: IconButton(
                                    onPressed: () => print('delete'),
                                    icon: const Icon(Icons.delete),
                                    iconSize: 24,
                                    splashRadius: 24,
                                  ),
                                  onTap: () => _bloc.add(EditEvent(
                                      state.persons?[index].id ?? '')),
                                );
                              },
                              shrinkWrap: true,
                            ),
                          )
                        : state is AddingState
                            ? const Expanded(
                                child: Center(
                                  child: Text('Inserindo'),
                                ),
                              )
                            : state is EditingState
                                ? const Expanded(
                                    child: Center(
                                      child: Text('Editando'),
                                    ),
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
