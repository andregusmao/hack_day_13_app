import 'package:person_app/bloc/person/person_bloc.dart';
import 'package:person_app/models/person_model.dart';

class LoadedState extends PersonState {
  final List<PersonModel>? persons;

  LoadedState(this.persons);
}
