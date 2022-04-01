class MovieGenre {
  final int __movieId;
  final int __genreId; 
 
  MovieGenre (
    {required int movieId,
    required int genreId})
    :__movieId = movieId,
    __genreId = genreId;

  factory MovieGenre.fromJSON(Map<String, dynamic> json) => MovieGenre(
    movieId: json['movie_id'] as int,
    genreId: json['genre_id'] as int);

  int getMovieId() => __movieId;
  int getGenreId() => __genreId;
  
}