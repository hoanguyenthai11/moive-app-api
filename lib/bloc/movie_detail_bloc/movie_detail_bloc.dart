import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_api/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:movie_app_api/bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:movie_app_api/services/api_service.dart';
import '../../models/movie.dart';
import '../../models/movie_detail.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailLoadingState()) {
    // on<MovieDetailEvent>(mapEventToSate);
    on<MovieDetailEvent>((event, emit) async {
      if (event is MovieDetailEventStarted) {
        final service = ApiService();
        emit(MovieDetailLoadingState());
        MovieDetail movieDetailList;
        try {
          movieDetailList = await service.getMovieDetail(event.id);
          emit(MovieDetailLoadedState(movieDetailList));
        } on Exception catch (e) {
          emit(MovieDetailErrorState(e.toString()));
        }
      }
    });
  }
}
