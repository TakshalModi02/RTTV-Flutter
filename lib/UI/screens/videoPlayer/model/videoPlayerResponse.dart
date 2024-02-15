class VideoPlayerResponseModel {
  final String id;
  final String movieName;
  final int releaseYear;
  final List<Map<String, dynamic>> cast;
  final int duration;
  final List<Map<String, dynamic>> languages;
  final List<Map<String, dynamic>> genres;
  final String description;
  final double star;
  final List<dynamic> ratings;
  final List<dynamic> reviews;
  final String link;

  VideoPlayerResponseModel(Map<String, dynamic> map)
      : id = map['_id'] ?? '',
        movieName = map['movie_name'] ?? '',
        releaseYear = map['release_year'] ?? 0,
        cast = List<Map<String, dynamic>>.from(map['cast']?.map((x) => {
                  'name': x['name'] ?? '',
                  '_id': x['_id'] ?? '',
                }) ??
            []),
        duration = map['duration'] ?? 0,
        languages =
            List<Map<String, dynamic>>.from(map['languages']?.map((x) => {
                      'language': x['language'] ?? '',
                      '_id': x['_id'] ?? '',
                    }) ??
                []),
        genres = List<Map<String, dynamic>>.from(map['genres']?.map((x) => {
                  'genre': x['genre'] ?? '',
                  '_id': x['_id'] ?? '',
                }) ??
            []),
        description = map['description'] ?? '',
        star = map['star']?.toDouble() ?? 0.0,
        ratings = map['ratings'] ?? [],
        reviews = map['reviews'] ?? [],
        link = map['link'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'movie_name': movieName,
      'release_year': releaseYear,
      'cast': cast.map((e) => {'name': e['name'], '_id': e['_id']}).toList(),
      'duration': duration,
      'languages': languages
          .map((e) => {'language': e['language'], '_id': e['_id']})
          .toList(),
      'genres':
          genres.map((e) => {'genre': e['genre'], '_id': e['_id']}).toList(),
      'description': description,
      'star': star,
      'ratings': ratings,
      'reviews': reviews,
      'link': link,
    };
  }
}
