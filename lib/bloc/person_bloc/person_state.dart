import 'package:equatable/equatable.dart';

import '../../models/person.dart';

abstract class PersonState extends Equatable {
  const PersonState();
  @override
  List<Object?> get props => [];
}

class PersonLoadingState extends PersonState {}

class PersonLoadedState extends PersonState {
  List<Person> personList;
  PersonLoadedState(this.personList);
  @override
  List<Object?> get props => [personList];
}

class PersonErrorState extends PersonState {}
