class CinemaMovie {
  final int __cinemaRoom;
  final int __movieId; 
  final DateTime __airingAt;
 
  CinemaMovie (
    {required int cinemaRoom,
    required int movieId,
    DateTime? airingAt})
    :__cinemaRoom = cinemaRoom,
    __movieId = movieId,
    __airingAt = airingAt!;

  factory CinemaMovie.fromJSON(Map<String, dynamic> json) => CinemaMovie(
    cinemaRoom: json['cinema_room'] as int,
    movieId: json['movie_id'] as int,
    airingAt: json['airing_at'] as DateTime);

  int getCinemaRoom() => __cinemaRoom;
  int getMovieId() => __movieId;
  DateTime getAiringAt() => __airingAt;
  
}