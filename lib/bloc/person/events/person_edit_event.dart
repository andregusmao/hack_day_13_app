import 'package:person_app/bloc/person/person_bloc.dart';

class EditEvent extends PersonEvent {
  final String id;

  EditEvent(this.id);
}
