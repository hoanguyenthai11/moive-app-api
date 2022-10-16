import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:movie_app_api/services/api_service.dart';
import '../../models/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading()) {
    // on<MovieEvent>(mapEventToSate);
    on<MovieEvent>((event, emit) async {
      if (event is MovieEventStarted) {
        final service = ApiService();
        emit(MovieLoading());
        List<Movie> movieList;
        print(event.movieId);
        try {
          if (event.movieId == 0) {
            movieList = await service.getNowPlayingMovie();
          } else {
            movieList = await service.getMovieByGenre(event.movieId);
          }
          emit(MovieLoaded(movieList));
        } on Exception catch (e) {
          emit(MovieError(e.toString()));
        }
      }
    });
  }
}
