import 'package:equatable/equatable.dart';

import '../../models/genre.dart';

abstract class GenreState extends Equatable {
  const GenreState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GenreLoadingState extends GenreState {}

class GenreLoadedState extends GenreState {
  List<Genre> genreList;

  GenreLoadedState(this.genreList);

  @override
  List<Object?> get props => [genreList];
}

class GenreErrorState extends GenreState {}
