part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class MovieEventStarted extends MovieEvent {
  final int movieId;
  final String query;

  const MovieEventStarted(this.movieId, this.query);

  @override
  // TODO: implement props
  List<Object> get props => [movieId, query];
}
