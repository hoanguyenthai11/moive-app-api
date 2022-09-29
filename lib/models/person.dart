class Person {
  final String id;
  final String genre;
  final String name;
  final String profilePath;
  final String knowForDepartment;
  final String popularity;

  Person(
      {required this.id,
      required this.genre,
      required this.name,
      required this.profilePath,
      required this.knowForDepartment,
      required this.popularity});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id']?.toString() ?? '',
      genre: json['genre']?.toString() ?? '',
      name: json['name'] ?? '',
      profilePath: json['profile_path'] ?? '',
      knowForDepartment: json['known_for_department'] ?? '',
      popularity: json['popularity']?.toString() ?? '',
    );
  }
}
