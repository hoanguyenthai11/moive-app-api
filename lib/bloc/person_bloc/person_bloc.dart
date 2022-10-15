import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_api/bloc/person_bloc/person_event.dart';
import 'package:movie_app_api/bloc/person_bloc/person_state.dart';
import 'package:movie_app_api/models/person.dart';

import '../../services/api_service.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonLoadingState()) {
    on<PersonEvent>((event, emit) async {
      if (event is PersonStartedEvent) {
        final service = ApiService();
        emit(PersonLoadingState());
        List<Person> personList;
        try {
          personList = await service.getTrendingPerson();
          emit(PersonLoadedState(personList));
        } on Exception catch (e) {
          emit(PersonErrorState(e.toString()));
        }
      }
    });
  }
}
