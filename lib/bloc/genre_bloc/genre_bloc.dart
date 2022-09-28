import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_api/bloc/genre_bloc/genre_event.dart';
import 'package:movie_app_api/bloc/genre_bloc/genre_state.dart';

import '../../models/genre.dart';
import '../../services/api_service.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreLoadingState()) {
    on<GenreEvent>((event, emit) async {
      if (event is GenreStartedEvent) {
        final service = ApiService();
        emit(GenreLoadingState());
        try {
          List<Genre> genreList;
          genreList = await service.getGenreList();
          emit(GenreLoadedState(genreList));
        } on Exception catch (e) {
          emit(GenreErrorState());
        }
      }
    });
  }
}

// on<MovieEvent>((event, emit) async {
//       if (event is MovieEventStarted) {
//         final service = ApiService();
//         emit(MovieLoading());
//         try {
//           if (event.movieId == 0) {
//             List<Movie> movieList;

//             movieList = await service.getNowPlayingMovie();
//             emit(MovieLoaded(movieList));
//           }
//         } on Exception catch (e) {
//           emit(MovieError());
//         }
//       }
//     });
