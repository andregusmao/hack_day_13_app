import 'package:person_app/bloc/person/person_bloc.dart';

class DeleteEvent extends PersonEvent {
  final String id;

  DeleteEvent(this.id);
}
