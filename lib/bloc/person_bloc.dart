import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:person_app/models/person_model.dart';
import 'package:person_app/services/person_service.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonService _service = PersonService();

  PersonBloc() : super(InitialState()) {
    on<LoadEvent>((event, emit) async {
      emit(WaitingState());
      List<PersonModel>? persons = await _service.getAll();
      await Future.delayed(const Duration(seconds: 3));
      if (persons == null) {
        emit(ErrorState());
      } else {
        emit(LoadedState(persons));
      }
    });
    on<AddEvent>((event, emit) async {
      emit(AddingState());
    });
    on<EditEvent>((event, emit) async {
      emit(WaitingState());
      PersonModel? person = await _service.getOne(event.id);
      if (person == null) {
        emit(ErrorState());
      } else {
        emit(EditingState(person));
      }
    });
    on<SaveEvent>((event, emit) async {
      emit(WaitingState());
      PersonModel? person;
      if (event.person.id == null) {
        person = await _service.insert(event.person);
      } else {
        person = await _service.update(event.person);
      }
      if (person == null) {
        emit(ErrorState());
      } else {
        List<PersonModel>? persons = await _service.getAll();
        await Future.delayed(const Duration(seconds: 3));
        if (persons == null) {
          emit(ErrorState());
        } else {
          emit(LoadedState(persons));
        }
      }
    });
    on<DeleteEvent>((event, emit) async {
      emit(WaitingState());
      await _service.delete(event.id);
      List<PersonModel>? persons = await _service.getAll();
      await Future.delayed(const Duration(seconds: 3));
      if (persons == null) {
        emit(ErrorState());
      } else {
        emit(LoadedState(persons));
      }
    });
  }
}
