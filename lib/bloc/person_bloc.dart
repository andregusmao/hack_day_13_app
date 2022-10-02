import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:person_app/models/person_model.dart';
import 'package:person_app/services/person_service.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonService _service = PersonService();

  PersonBloc() : super(InitialState()) {
    on<LoadEvent>((event, emit) async {
      print('load');
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
      print('add');
      emit(AddingState());
    });
    on<EditEvent>((event, emit) async {
      print('edit');
      emit(WaitingState());
      PersonModel? person = await _service.getOne(event.id);
      if (person == null) {
        emit(ErrorState());
      } else {
        emit(EditingState(person));
      }
    });
  }
}
