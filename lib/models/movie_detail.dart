import 'package:movie_app_api/models/cast.dart';
import 'package:movie_app_api/models/movie_image.dart';

class MovieDetail {
  final String id;
  final String title;
  final String backdropPath;
  final String budget;
  final String homePage;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final String runtime;
  final String voteAverage;
  final String voteCount;
  String? trailerId;

  MovieImage? movieImage;

  late List<Cast> castList;

  MovieDetail({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.budget,
    required this.homePage,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      budget: json['budget']?.toString() ?? '',
      homePage: json['home_page'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime']?.toString() ?? '',
      voteAverage: json['vote_average']?.toString() ?? '',
      voteCount: json['vote_count']?.toString() ?? '',
    );
  }
}
