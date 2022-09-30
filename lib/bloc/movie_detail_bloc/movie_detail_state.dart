import 'package:equatable/equatable.dart';
import 'package:movie_app_api/models/movie_detail.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailLoadedState extends MovieDetailState {
  MovieDetail movieDetailList;

  MovieDetailLoadedState(this.movieDetailList);

  @override
  List<Object> get props => [movieDetailList];
}

class MovieDetailErrorState extends MovieDetailState {
  String err;

  MovieDetailErrorState(this.err);
}
