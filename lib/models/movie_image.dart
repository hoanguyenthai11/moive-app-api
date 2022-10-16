import 'package:equatable/equatable.dart';
import 'package:movie_app_api/models/screen_shot.dart';

class MovieImage extends Equatable {
  final List<Screenshot> backdrops;
  final List<Screenshot> posters;

  const MovieImage({required this.backdrops, required this.posters});

  factory MovieImage.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return const MovieImage(backdrops: [], posters: []);
    }

    return MovieImage(
      backdrops: (json['backdrops'] as List)
          .map((b) => Screenshot.fromJson(b))
          .toList(),
      posters:
          (json['posters'] as List).map((b) => Screenshot.fromJson(b)).toList(),
    );
  }
  @override
  List<Object?> get props => [backdrops, posters];
}
