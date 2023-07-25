import 'package:person_app/bloc/person/person_bloc.dart';
import 'package:person_app/models/person_model.dart';

class EditingState extends PersonState {
  final PersonModel person;

  EditingState(this.person);
}
