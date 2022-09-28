import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:movie_app_api/models/genre.dart';
import 'package:movie_app_api/models/movie.dart';

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
}
