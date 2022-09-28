class Genre {
  final int? genreId;
  final String? genreName;

  String? error;

  Genre({this.genreId, this.genreName});

  Genre.withError(this.error, this.genreId, this.genreName);

  factory Genre.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return Genre();
    }
    return Genre(
      genreId: json['id'],
      genreName: json['name'],
    );
  }
}
