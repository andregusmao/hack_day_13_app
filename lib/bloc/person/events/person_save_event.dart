import 'package:person_app/bloc/person/person_bloc.dart';
import 'package:person_app/models/person_model.dart';

class SaveEvent extends PersonEvent {
  final PersonModel person;

  SaveEvent(this.person);
}
