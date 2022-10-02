part of 'person_bloc.dart';

@immutable
abstract class PersonState {}

class InitialState extends PersonState {}

class WaitingState extends PersonState {}

class LoadedState extends PersonState {
  final List<PersonModel>? persons;

  LoadedState(this.persons);
}

class AddingState extends PersonState {}

class EditingState extends PersonState {
  final PersonModel person;

  EditingState(this.person);
}

class ErrorState extends PersonState {}
