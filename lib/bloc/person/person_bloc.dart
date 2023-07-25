import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:person_app/bloc/person/events/person_add_event.dart';
import 'package:person_app/bloc/person/events/person_delete_event.dart';
import 'package:person_app/bloc/person/events/person_edit_event.dart';
import 'package:person_app/bloc/person/events/person_load_event.dart';
import 'package:person_app/bloc/person/events/person_save_event.dart';
import 'package:person_app/bloc/person/states/person_adding_state.dart';
import 'package:person_app/bloc/person/states/person_editing_state.dart';
import 'package:person_app/bloc/person/states/person_error_state.dart';
import 'package:person_app/bloc/person/states/person_initial_state.dart';
import 'package:person_app/bloc/person/states/person_loaded_state.dart';
import 'package:person_app/bloc/person/states/person_waiting_state.dart';
import 'package:person_app/models/person_model.dart';
import 'package:person_app/services/person_service.dart';

part 'events/person_event.dart';
part 'states/person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonService _service = PersonService();

  PersonBloc() : super(InitialState()) {
    on<LoadEvent>((event, emit) async {
      emit(WaitingState());
      List<PersonModel>? persons = await _service.getAll();
      if (persons == null) {
        emit(ErrorState('Não foi possível listar as pessoas'));
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
        emit(ErrorState('Pessoa não encontrada'));
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
        emit(ErrorState('Pessoa não encontrada'));
      } else {
        List<PersonModel>? persons = await _service.getAll();
        if (persons == null) {
          emit(ErrorState('Não foi possível listar as pessoas'));
        } else {
          emit(LoadedState(persons));
        }
      }
    });
    on<DeleteEvent>((event, emit) async {
      emit(WaitingState());
      await _service.delete(event.id);
      List<PersonModel>? persons = await _service.getAll();
      if (persons == null) {
        emit(ErrorState('Pessoa não encontrada'));
      } else {
        emit(LoadedState(persons));
      }
    });
  }
}
