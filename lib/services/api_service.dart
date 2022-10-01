import 'package:dio/dio.dart';
import 'package:movie_app_api/models/genre.dart';
import 'package:movie_app_api/models/movie.dart';
import 'package:movie_app_api/models/movie_detail.dart';
import 'package:movie_app_api/models/movie_image.dart';
import 'package:movie_app_api/models/person.dart';

import '../models/cast.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=70e2972cc7eba0f186949ad7cc819da3';
  final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/550?api_key=70e2972cc7eba0f186949ad7cc819da3');

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final Response response =
          await _dio.get('$baseUrl/movie/now_playing?$apiKey');
      List movies = response.data["results"] as List;

      List<Movie> movieList = movies.map((e) => Movie.fromJson(e)).toList();

      return movieList;
    } catch (e, stracktrace) {
      print('Err');
      throw Exception('Exeption accoured $e with stacktrace: $stracktrace');
    }
  }

  Future<List<Movie>> getMovieByGenre(int movieId) async {
    try {
      final Response response = await _dio
          .get('$baseUrl/discover/movie?with_genres=$movieId&$apiKey');

      List movies = response.data['results'] as List;

      List<Movie> movieList = movies.map((e) => Movie.fromJson(e)).toList();

      return movieList;
    } catch (e, stracktrace) {
      throw Exception('Exeption accoured $e with stacktrace: $stracktrace');
    }
  }

  Future<List<Genre>> getGenreList() async {
    try {
      final Response response =
          await _dio.get('$baseUrl/genre/movie/list?$apiKey');
      List genres = response.data['genres'] as List;

      List<Genre> genreList = genres.map((e) => Genre.fromJson(e)).toList();
      return genreList;
    } catch (e, stracktrace) {
      throw Exception('Exeption accoured $e with stacktrace: $stracktrace');
    }
  }

  Future<List<Person>> getTrendingPerson() async {
    try {
      final Response response =
          await _dio.get('$baseUrl/trending/person/week?$apiKey');
      List person = response.data['results'] as List;

      List<Person> personList = person.map((e) => Person.fromJson(e)).toList();
      return personList;
    } catch (e, stracktrace) {
      throw Exception('Exeption accoured $e with stacktrace: $stracktrace');
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final Response response =
          await _dio.get('$baseUrl/movie/$movieId?$apiKey');

      MovieDetail movieDetail = MovieDetail.fromJson(response.data);

      movieDetail.trailerId = await getYoutubeId(movieId);

      movieDetail.movieImage = await getMovieImage(movieId);

      movieDetail.castList = await getCastList(movieId);
      return movieDetail;
    } catch (e, stracktrace) {
      throw Exception('Exeption accoured $e with stacktrace: $stracktrace');
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final Response response =
          await _dio.get('$baseUrl/movie/$id/videos?$apiKey');

      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (e, stracktrace) {
      throw Exception('Exeption accoured $e with stacktrace: $stracktrace');
    }
  }

  Future<MovieImage> getMovieImage(int movieId) async {
    try {
      final Response response =
          await _dio.get('$baseUrl/movie/$movieId/images?$apiKey');
      return MovieImage.fromJson(response.data);
    } catch (e, stracktrace) {
      throw Exception('Exeption accoured $e with stacktrace: $stracktrace');
    }
  }

  Future<List<Cast>> getCastList(int movieId) async {
    try {
      final Response response =
          await _dio.get('$baseUrl/movie/$movieId/credits?$apiKey');

      var list = response.data['cast'] as List;
      List<Cast> castList = list.map((e) => Cast.fromJson(e)).toList();
      return castList;
    } catch (e, stracktrace) {
      throw Exception('Exeption accoured $e with stacktrace: $stracktrace');
    }
  }
}
