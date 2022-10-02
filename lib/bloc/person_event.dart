part of 'person_bloc.dart';

@immutable
abstract class PersonEvent {}

class ReloadEvent extends PersonEvent {}

class DeleteEvent extends PersonEvent {}
