part of 'person_bloc.dart';

@immutable
abstract class PersonEvent {}

class LoadEvent extends PersonEvent {}

class AddEvent extends PersonEvent {}

class EditEvent extends PersonEvent {
  final String id;

  EditEvent(this.id);
}
