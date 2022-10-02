import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_app/bloc/person_bloc.dart';

class PersonView extends StatelessWidget {
  const PersonView({super.key});

  @override
  Widget build(BuildContext context) {
    PersonBloc _bloc = BlocProvider.of<PersonBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pessoas'),
      ),
      body: BlocListener<PersonBloc, PersonState>(
        listener: (context, state) {},
        child: BlocBuilder<PersonBloc, PersonState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                state is Loaded
                    ? ListView.builder(
                        itemCount: state.persons?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                '${state.persons?[index].firstname ?? ''} ${state.persons?[index].surname ?? ''}'),
                            subtitle: Text(state.persons?[index].email ?? ''),
                          );
                        },
                        shrinkWrap: true,
                      )
                    : state is Loading
                        ? Stack(
                            children: const [
                              LinearProgressIndicator(),
                              Center(child: Text('Carregando...')),
                            ],
                          )
                        : Expanded(child: Container()),
                ElevatedButton(
                  child: const Text('Recarregar'),
                  onPressed: () => _bloc.add(ReloadEvent()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
