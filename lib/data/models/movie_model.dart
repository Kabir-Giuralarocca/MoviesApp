class Movie {
  final int id;
  final String title;
  final String description;
  final String director;
  final String genre;
  final String duration;
  final DateTime releaseDate;
  final int rating;
  final String? image;

  Movie({
    this.id = 0,
    required this.title,
    required this.description,
    required this.director,
    required this.genre,
    required this.duration,
    required this.releaseDate,
    required this.rating,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'director': director,
      'genre': genre,
      'duration': duration,
      'releaseDate': releaseDate,
      'rating': rating,
      'image': image,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      director: map['director'] as String,
      genre: map['genre'] as String,
      duration: map['duration'] as String,
      releaseDate: DateTime.parse(
        map['releaseDate'] as String,
      ),
      rating: map['rating'] as int,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }
}
