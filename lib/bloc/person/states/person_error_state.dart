import 'package:person_app/bloc/person/person_bloc.dart';

class ErrorState extends PersonState {
  final String message;

  ErrorState(this.message);
}
