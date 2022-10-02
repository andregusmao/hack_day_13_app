part of 'person_bloc.dart';

@immutable
abstract class PersonState {}

class Initial extends PersonState {}

class Loading extends PersonState {}

class Loaded extends PersonState {
  final List<PersonModel>? persons;

  Loaded(this.persons);
}
