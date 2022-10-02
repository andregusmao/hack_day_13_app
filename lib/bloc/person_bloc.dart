import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:person_app/models/person_model.dart';
import 'package:person_app/services/person_service.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonService _service = PersonService();

  PersonBloc() : super(Initial()) {
    on<ReloadEvent>((event, emit) async {
      emit(Loading());
      List<PersonModel>? persons = await _service.getAll();
      await Future.delayed(const Duration(seconds: 3));
      emit(Loaded(persons));
    });
  }
}
